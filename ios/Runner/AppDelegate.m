#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                              methodChannelWithName:@"samples.flutter.dev/battery"
                                              binaryMessenger:controller.binaryMessenger];
    __weak typeof(self) weakSelf = self;
    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
       // This method is invoked on the UI thread.
        if ([@"getBatteryLevel" isEqualToString:call.method]) {
            int batteryLevel = [weakSelf getBatteryLevel];

            if (batteryLevel == -1) {
              result([FlutterError errorWithCode:@"UNAVAILABLE"
                                         message:@"Battery level not available."
                                         details:nil]);
            } else {
              result(@(batteryLevel));
            }
          } else {
            result(FlutterMethodNotImplemented);
          }
     }];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

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
