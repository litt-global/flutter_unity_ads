import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_unity_ads/flutter_unity_ads.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_unity_ads');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterUnityAds.platformVersion, '42');
  });
}
