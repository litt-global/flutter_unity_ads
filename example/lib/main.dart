import 'package:flutter/material.dart';
import 'package:flutter_unity_ads/flutter_unity_ads.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with UnityAdsListener {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    FlutterUnityAds.initialize('124124', '', this, testMode: true);
    Future.delayed(Duration(seconds: 10), () {
      FlutterUnityAds.show();
    });
  }

  @override
  void onUnityAdsError(UnityAdsError error, String message) {
    error;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }

  @override
  void onUnityAdsFinish(String placementId, FinishState result) {}

  @override
  void onUnityAdsReady(String placementId) {}

  @override
  void onUnityAdsStart(String placementId) {}
}
