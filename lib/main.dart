import 'dart:async';
import 'dart:ui';

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

void main() async {
  // 捕获 Flutter 应用中的未处理异常
  runZonedGuarded<void>(
    () async {
      // 某些插件（如sqflite）需要使用WidgetsFlutterBinding.ensureInitialized（）方法
      // 因为它们需要访问特定于平台的通道才能正常工作。这就是为什么ensureInitialized（）方法经常放在Flutter应用的main（）函数中
      // WidgetsFlutterBinding就是一个胶水类，用于初始化其他with的minxin类
      WidgetsFlutterBinding.ensureInitialized()
          .addTimingsCallback(onReportTimings); // 设置帧回调函数并保存原始帧回调函数

      FlutterError.onError = (FlutterErrorDetails details) async {
        // 将异常转发至 Zone
        Zone.current.handleUncaughtError(
            details.exception, StackTrace.fromString(details.stack.toString()));
      };

      // debugPaintSizeEnabled = true; // 打开 Debug Painting 调试开关
      runApp(const MyApp());

      // orginalCallback = window.onReportTimings;
      // window.onReportTimings = onReportTimings;
    },
    (error, stackTrace) async {
      // 拦截异常
      await reportError(error, stackTrace);
    },
  );
}

// 定义需要共享的数据模型，通过混入 ChangeNotifier 管理听众
class CounterModel with ChangeNotifier {
  int _count = 0;
  // 读方法
  int get counter => _count;
  // 写方法
  void increment() {
    _count++;
    notifyListeners(); // 通知听众刷新
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // iOS 浅色主题
    final ThemeData kIOSTheme = ThemeData(
        brightness: Brightness.light, // 亮色主题
        accentColor: Colors.white, //(按钮)Widget 前景色为白色
        primaryColor: Colors.blue, // 主题色为蓝色
        iconTheme: IconThemeData(color: Colors.grey), //icon 主题为灰色
        textTheme:
            TextTheme(bodyText2: TextStyle(color: Colors.black)) // 文本主题为黑色
        );
    // Android 深色主题
    final ThemeData kAndroidTheme = ThemeData(
        brightness: Brightness.dark, // 深色主题
        accentColor: Colors.black, //(按钮)Widget 前景色为黑色
        primaryColor: Colors.cyan, // 主题色 Wie 青色
        iconTheme: IconThemeData(color: Colors.blue), //icon 主题色为蓝色
        textTheme:
            TextTheme(bodyText2: TextStyle(color: Colors.red)) // 文本主题色为红色
        );

    final ThemeData defaultThemeData = ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // brightness: Brightness.dark, // 明暗模式为暗色
        primarySwatch: Colors.cyan, // 导航栏颜色
        primaryColor: Colors.cyan, // 主色调为青色
        iconTheme: const IconThemeData(color: Colors.yellow), // 设置 icon 主题色为黄色
        textTheme: const TextTheme(
            bodyText2: TextStyle(color: Colors.black87)) // 设置文本颜色为红色
        );
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
                // 路由表实际上是一个 Map<String,WidgetBuilder>
                routes: {
                  '/': (context) => HomePage(),
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
