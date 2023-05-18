import 'dart:async';

import 'package:dolin/app/services/user.dart';
import 'package:dolin/app/util/fps_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/modules/debug/log/log.dart';
import 'app/services/app_settings_service.dart';
import 'app/services/storage_service.dart';

// import 'package:flutter_bugly/flutter_bugly.dart';

/// 防御启动
class DLAPPDefend {
  // 设置状态栏为透明
  setSystemUi() async {
    // 只允许竖屏
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    if (GetPlatform.isAndroid) {
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  /// 初始化服务
  Future initServices() async {
    await Get.put<StorageService>(StorageService()).init(); // 注意：put 后 init
    Get.put<UserStore>(UserStore());

    /// 初始化设置服务
    Get.put(AppSettingsService());
  }

  /// 设置 debugPrint
  void setDebugPrint() {
    if (kReleaseMode) {
      // 如果是线上环境，将 debugPrint 指定为空的执行体, 所以线上它什么也不做
      debugPrint = (String? message, {int? wrapWidth}) {};
    }
  }

  /// flutter 框架异常
  void setFlutterFrameworkError() {
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
  }

  /// run zone
  void _runZone(Widget app) {
    runZonedGuarded(
      () {
        // FlutterBugly.postCatchedException(() {
        runApp(app);
        // });
      },
      (error, stackTrace) {
        // 全局异常
        Log.e(error.toString(), stackTrace);
      },
    );
  }

  run(Widget app) async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    widgetsBinding.addTimingsCallback(onReportTimings); // 设置帧回调函数

    await setSystemUi();
    await Hive.initFlutter();
    await initServices();
    setDebugPrint();
    setFlutterFrameworkError();

    _runZone(app);
  }
}
