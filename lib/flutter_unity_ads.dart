import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

enum FinishState { error, skipped, completed }

enum PlacementState { ready, not_available, disabled, waiting, no_fill }

enum UnityAdsError {
  not_initialized,
  initialize_failed,
  invalid_argument,
  video_player_error,
  init_sanity_check_fail,
  ad_blocker_detected,
  file_io_error,
  device_id_error,
  show_error,
  internal_error,
}

class FlutterUnityAds {
  static const MethodChannel _channel = const MethodChannel('flutter_unity_ads');

  static UnityAdsListener _listener;

  static UnityAdsListener getListener() {
    return _listener;
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Null> initialize(
    final String gameAndroidId,
    final String gameIosId,
    final UnityAdsListener listener, {
    final bool testMode = false,
  }) async {
    String gameId;
    if (Platform.isAndroid) {
      gameId = gameAndroidId;
    } else if (Platform.isIOS) {
      gameId = gameIosId;
    } else {
      throw new UnsupportedError('Unsupported Platform! Only Android and IOS are supported!');
    }
    _listener = listener;
    _channel.setMethodCallHandler(_listener._handle);
    await _channel.invokeMethod('initialize', {
      'gameId': gameId,
      'testMode': testMode,
    });
  }

  static Future<bool> isInitialized() async {
    bool initialized = await _channel.invokeMethod('isInitialized');
    return initialized;
  }

  static Future<bool> isDefaultReady() async {
    bool ready = await _channel.invokeMethod('isDefaultReady');
    return ready;
  }

  static Future<bool> isReady() async {
    bool ready = await _channel.invokeMethod('isReady');
    return ready;
  }

  static Future<bool> isSupported() async {
    bool supported = await _channel.invokeMethod('isSupported');
    return supported;
  }

  static Future<Null> setDebugMode(bool debugMode) async {
    await _channel.invokeMethod('setDebugMode', {'debugMode': debugMode});
  }

  static void setListener(UnityAdsListener listener) {
    _listener = listener;
    _channel.setMethodCallHandler(_listener._handle);
  }

  static Future<Null> showDefault() async {
    await _channel.invokeMethod('showDefault');
  }

  static Future<Null> show({String placementId}) async {
    await _channel.invokeMethod('show', {'placementId': placementId});
  }

  static Future<Null> showWithServerCallback({String placementId, String serverId}) async {
    await _channel.invokeMethod('showWithServerCallback', {'placementId': placementId, 'serverId': serverId});
  }
}

abstract class UnityAdsListener {
  Future<Null> _handle(MethodCall methodCall) async {
    if (methodCall.method == 'onUnityAdsError') {
      onUnityAdsError(UnityAdsError.values[methodCall.arguments['error']], methodCall.arguments['message']);
    } else if (methodCall.method == 'onUnityAdsFinish') {
      onUnityAdsFinish(methodCall.arguments['placementId'], FinishState.values[methodCall.arguments['result']]);
    } else if (methodCall.method == 'onUnityAdsReady') {
      onUnityAdsReady(methodCall.arguments);
    } else if (methodCall.method == 'onUnityAdsStart') {
      onUnityAdsStart(methodCall.arguments);
    }
  }

  void onUnityAdsError(UnityAdsError error, String message);

  void onUnityAdsFinish(String placementId, FinishState result);

  void onUnityAdsReady(String placementId);

  void onUnityAdsStart(String placementId);
}
