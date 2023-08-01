import 'package:flutter_plugin_practice/flutter_plugin_practice.dart';
import 'package:flutter_plugin_practice/flutter_plugin_practice_method_channel.dart';
import 'package:flutter_plugin_practice/flutter_plugin_practice_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPluginPracticePlatform
    with MockPlatformInterfaceMixin
    implements FlutterPluginPracticePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<int?> getBatteryLevel() {
    // TODO: implement getBatteryLevel
    throw UnimplementedError();
  }

  @override
  Future<int?> add(int a, int b) {
    // TODO: implement add
    throw UnimplementedError();
  }
}

void main() {
  final FlutterPluginPracticePlatform initialPlatform =
      FlutterPluginPracticePlatform.instance;

  test('$MethodChannelFlutterPluginPractice is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPluginPractice>());
  });

  test('getPlatformVersion', () async {
    FlutterPluginPractice flutterPluginPracticePlugin = FlutterPluginPractice();
    MockFlutterPluginPracticePlatform fakePlatform =
        MockFlutterPluginPracticePlatform();
    FlutterPluginPracticePlatform.instance = fakePlatform;

    expect(await flutterPluginPracticePlugin.getPlatformVersion(), '42');
  });
}
