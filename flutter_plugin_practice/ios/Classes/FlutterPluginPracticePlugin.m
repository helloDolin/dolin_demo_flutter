#import "FlutterPluginPracticePlugin.h"

@implementation FlutterPluginPracticePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_plugin_practice"
            binaryMessenger:[registrar messenger]];
  FlutterPluginPracticePlugin* instance = [[FlutterPluginPracticePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"getBatteryLevel" isEqualToString:call.method]) {
        int batteryLevel = [self getBatteryLevel];
        if (batteryLevel == -1) {
            result([FlutterError errorWithCode:@"UNAVAILABLE" message:@"Battery level not available." details:nil]);
        } else {
            result(@(batteryLevel));
        }
    } else {
        result(FlutterMethodNotImplemented);
    }
}

/// 获取电量
- (int)getBatteryLevel {
  UIDevice* device = UIDevice.currentDevice;
  device.batteryMonitoringEnabled = YES;
  if (device.batteryState == UIDeviceBatteryStateUnknown) {
    return -1;
  } else {
    return (int)(device.batteryLevel * 100);
  }
}

@end
