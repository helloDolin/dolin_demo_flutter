import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_plugin_practice_method_channel.dart';

abstract class FlutterPluginPracticePlatform extends PlatformInterface {
  /// Constructs a FlutterPluginPracticePlatform.
  FlutterPluginPracticePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPluginPracticePlatform _instance =
      MethodChannelFlutterPluginPractice();

  /// The default instance of [FlutterPluginPracticePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPluginPractice].
  static FlutterPluginPracticePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPluginPracticePlatform] when
  /// they register themselves.
  static set instance(FlutterPluginPracticePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<int?> getBatteryLevel() {
    throw UnimplementedError('getBatteryLevel() has not been implemented.');
  }
}
