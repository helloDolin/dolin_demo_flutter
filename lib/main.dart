import 'dart:async';

import 'package:dolin_demo_flutter/util/fps.dart';
import 'package:dolin_demo_flutter/util/pv_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dolin_demo_flutter/pages/arena.dart';
import 'package:dolin_demo_flutter/pages/async.dart';
import 'package:dolin_demo_flutter/pages/customPaint.dart';
import 'package:dolin_demo_flutter/pages/home.dart';
import 'package:dolin_demo_flutter/pages/scrollView.dart';
import 'package:dolin_demo_flutter/pages/unknow.dart';
import 'package:provider/provider.dart';

import 'model/counter.dart';
import 'model/themeData.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 既然 Provider 是 InheritedWidget 的语法糖，
    // 因此它也是一个 Widget。所以，我们直接在 MaterialApp 的外
    // 层使用 Provider 进行包装，就可以把数据资源依赖注入到应用中
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return ChangeNotifierProvider.value(
              value: CounterModel(),
              child: MaterialApp(
                navigatorObservers: [
                  MyObserver(),
                ],
                debugShowCheckedModeBanner: true,
                title: 'Flutter Demo',
                theme: defaultTargetPlatform == TargetPlatform.iOS
                    ? kIOSTheme
                    : kAndroidTheme, // 根据平台选择不同主题
                routes: {
                  // 路由表实际上是一个 Map<String,WidgetBuilder>
                  '/': (context) => const HomePage(),
                  '/scrollViewPage': (context) => const ScrollViewPage(),
                  '/customPaintPage': (context) => const CustomPaintPage(),
                  '/arenaPage': (context) => const ArenaPage(),
                  '/asyncPage': (context) => const AsyncPage(),
                },
                // 错误路由处理，统一返回 UnknownPage
                onUnknownRoute: (RouteSettings setting) =>
                    MaterialPageRoute(builder: (context) => const UnKnowPage()),
                initialRoute: '/',
              ));
        });
  }
}
