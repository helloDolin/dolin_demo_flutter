import 'dart:async';

import 'package:dolin_demo_flutter/app/util/fps.dart';
import 'package:dolin_demo_flutter/app/util/pv_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  // 捕获 Flutter 应用中的未处理异常
  runZonedGuarded<void>(
    () async {
      // 某些插件（如sqflite）需要使用WidgetsFlutterBinding.ensureInitialized（）方法
      // 因为它们需要访问特定于平台的通道才能正常工作。这就是为什么ensureInitialized（）方法经常放在Flutter应用的main（）函数中
      // WidgetsFlutterBinding就是一个胶水类，用于初始化其他with的minxin类
      WidgetsFlutterBinding.ensureInitialized()
          .addTimingsCallback(onReportTimings); // 设置帧回调函数

      FlutterError.onError = (FlutterErrorDetails details) async {
        // 将异常转发至 Zone
        Zone.current.handleUncaughtError(
            details.exception, StackTrace.fromString(details.stack.toString()));
      };
      if (kReleaseMode) {
        // 如果是线上环境，将 debugPrint 指定为空的执行体, 所以它什么也不做
        debugPrint = (String? message, {int? wrapWidth}) {};
      }
      runApp(
        // UI 适配不同终端
        ScreenUtilInit(
            designSize: const Size(1080, 2400), // 设计搞中的宽高
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: "Application",
                initialRoute: AppPages.INITIAL,
                getPages: AppPages.routes,
                theme: ThemeData(
                  primaryColor: Colors.black38,
                  primaryColorLight: Colors.black38,
                  primaryColorDark: Colors.white,
                ),
              );
            }),
      );
    },
    (error, stackTrace) async {
      // 拦截异常
      await reportError(error, stackTrace);
    },
  );
}
