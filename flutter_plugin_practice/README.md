# flutter_plugin_practice

A new Flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 
参考文章：
https://blog.csdn.net/sinat_17775997/article/details/110438289
### 使用的命令：

创建插件：
flutter create -t plugin flutter_plugin_practice --platform=android,ios -a java -i objc

在 example 目录下 build
/Users/liaoshaolin/Desktop/dolin_demo_flutter/flutter_plugin_practice/example
flutter build ios --no-codesign 

调试需要再 example 目录下打开

原生侧编码
以 iOS 举例，在原生侧启动后，在 Development Pods 下的 flutter_plugin_practice 下的 Classess 编码，会同步修改外层目录代码，这里编码方便调试，Android 同理

