import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_plugin_practice_platform_interface.dart';

/// An implementation of [FlutterPluginPracticePlatform] that uses method channels.
class MethodChannelFlutterPluginPractice extends FlutterPluginPracticePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_plugin_practice');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<int?> getBatteryLevel() async {
    final level = await methodChannel.invokeMethod<int>('getBatteryLevel');
    return level;
  }

  @override
  Future<int?> add(int a, int b) async {
    final level = await methodChannel.invokeMethod<int>('add', <String, int>{
      'a': a,
      'b': b,
    });
    return level;
  }
}
