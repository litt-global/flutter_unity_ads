#import "FlutterUnityAdsPlugin.h"
#import <flutter_unity_ads/flutter_unity_ads-Swift.h>

@implementation FlutterUnityAdsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterUnityAdsPlugin registerWithRegistrar:registrar];
}
@end
