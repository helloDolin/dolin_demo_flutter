import 'dart:async';

import 'package:dolin_demo_flutter/style/theme.dart';
import 'package:dolin_demo_flutter/pages/unknow.dart';
import 'package:dolin_demo_flutter/routers/routes.dart';
import 'package:dolin_demo_flutter/util/app_module.dart';
import 'package:dolin_demo_flutter/util/fps.dart';
import 'package:dolin_demo_flutter/util/pv_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'models/counter.dart';

import 'module/login/module.dart' as login;
import 'module/signin/module.dart' as signin;

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
      // debugPaintSizeEnabled = true; // 打开 Debug Painting 调试开关
      runApp(const MyApp());
    },
    (error, stackTrace) async {
      // 拦截异常
      await reportError(error, stackTrace);
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AppModule {
  @override
  void initState() {
    super.initState();
    registerModule(this);
    initModules();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    print('main onInit');
  }

  @override
  void onRegister() {
    registerModule(login.Module());
    registerModule(signin.Module());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return ChangeNotifierProvider<CounterModel>(
              create: (_) => CounterModel(),
              child: GetMaterialApp(
                  title: 'dolin_demo_flutter', // 安卓这个字段有用
                  theme: AppTheme.light,
                  debugShowCheckedModeBanner: true,
                  // initialRoute: AppPages.INITIAL,
                  home: MaterialApp(
                    navigatorObservers: [
                      MyObserver(),
                    ],
                    debugShowCheckedModeBanner: true,
                    // theme: defaultTargetPlatform == TargetPlatform.iOS
                    //     ? kIOSTheme
                    //     : kAndroidTheme, // 根据平台选择不同主题
                    routes: appRoutes,
                    // 错误路由处理，统一返回 UnknownPage
                    onUnknownRoute: (RouteSettings setting) =>
                        MaterialPageRoute(
                            builder: (context) => const UnKnowPage()),
                    initialRoute: '/',
                  )));
        });
  }
}
