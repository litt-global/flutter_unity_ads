# flutter_unity_ads

flutter_unity_ads plugin.

## Getting Started

To implement `UnityAdsListener`
```
class _MyAppState extends State<MyApp> with UnityAdsListener {
```

To `initialize` and `show` ads.
```
FlutterUnityAds.initialize('124124', '18660', this, testMode: true);
FlutterUnityAds.show();
```

Note:
`124124` is android game id test
`18660` is ios game id test
