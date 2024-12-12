//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import desktop_window
import device_info_plus
import file_selector_macos
import package_info_plus
import path_provider_foundation
import sqflite
import wakelock_plus

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  DesktopWindowPlugin.register(with: registry.registrar(forPlugin: "DesktopWindowPlugin"))
  DeviceInfoPlusMacosPlugin.register(with: registry.registrar(forPlugin: "DeviceInfoPlusMacosPlugin"))
  FileSelectorPlugin.register(with: registry.registrar(forPlugin: "FileSelectorPlugin"))
  FPPPackageInfoPlusPlugin.register(with: registry.registrar(forPlugin: "FPPPackageInfoPlusPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
  WakelockPlusMacosPlugin.register(with: registry.registrar(forPlugin: "WakelockPlusMacosPlugin"))
}
