import 'dart:async';

import 'package:dolin_demo_flutter/app/util/fps.dart';
import 'package:dolin_demo_flutter/app/util/pv_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_bugly/flutter_bugly.dart';

class DLAPPDefend {
  run(Widget app) {
    // 某些插件（如sqflite）需要使用WidgetsFlutterBinding.ensureInitialized（）方法
    // 因为它们需要访问特定于平台的通道才能正常工作。这就是为什么ensureInitialized（）方法经常放在Flutter应用的main（）函数中
    // WidgetsFlutterBinding就是一个胶水类，用于初始化其他with的minxin类
    WidgetsFlutterBinding.ensureInitialized()
        .addTimingsCallback(onReportTimings); // 设置帧回调函数

    if (kReleaseMode) {
      // 如果是线上环境，将 debugPrint 指定为空的执行体, 所以它什么也不做
      debugPrint = (String? message, {int? wrapWidth}) {};
    }

    // 框架异常
    FlutterError.onError = (FlutterErrorDetails details) async {
      if (kReleaseMode) {
        // 线上环境，走上报流程
        // 将异常转发至 Zone
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      } else {
        // 开发期间，走控制台
        FlutterError.dumpErrorToConsole(details);
      }
    };
    runZonedGuarded(() {
      // FlutterBugly.postCatchedException(() {
      runApp(app);
      // });
    }, (e, s) => _reportError(e, s));
  }

  _reportError(Object error, StackTrace s) {
    reportError(error, s);
    print("当前环境:$kReleaseMode");
    print("catch error:$error");
  }
}
