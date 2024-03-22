# 查看所有命令
flutter

# 根据 .metadata 文件查看当前 flutter 版本
https://github.com/flutter/flutter/commit/{revision}
revision 为 .metadata reversion 字段

# 查看当前 flutter 版本
flutter --version

# 查看当前 dart 版本
dart --version

# 判断那些过时了的package 依赖以及获取更新建议
flutter pub outdated

# 代码分析（同 VSCode 下 issues）
flutter analyze lib/

# 查看三方库依赖关系
flutter pub deps

# 查看设备（真机+模拟器）
flutter devices

# 禁用 windows 平台
flutter config --no-enable-windows-desktop
其他具体查看 flutter config --help

# Android 打包
## Android 产物： aar
flutter build aar --no-debug --no-profile --release
flutter build aar --no-debug --no-profile --release --build-number="$build_aar_version"

## Android 产物： apk
flutter build apk --release

## iOS 产物：framework
flutter build ios-framework --no-debug --no-profile --release

## iOS 产物：ipa
flutter build ios --release

## 清除 pub cache
flutter pub cache clean