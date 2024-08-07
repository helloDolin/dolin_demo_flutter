import 'dart:async';
import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:dolin/app/modules/debug/log/log.dart';
import 'package:dolin/app/services/app_settings_service.dart';
import 'package:dolin/app/services/storage_service.dart';
import 'package:dolin/app/services/user.dart';
import 'package:dolin/app/util/fps_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'package:flutter_bugly/flutter_bugly.dart';

/// 防御启动
class DLAPPDefend {
  // 设置状态栏为透明
  Future<void> setSystemUi() async {
    // 只允许竖屏
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    if (GetPlatform.isAndroid) {
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      const systemUiOverlayStyle = SystemUiOverlayStyle(
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
  Future<void> initServices() async {
    // await Get.putAsync(() => GlobalConfigService().init());
    await Get.put<StorageService>(StorageService())
        .init(); // 注意：put 后调用 init 实例方法
    Get.put<UserStore>(UserStore());

    /// 初始化设置服务
    // ignore: cascade_invocations
    Get.put<AppSettingsService>(AppSettingsService());
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

  Future<void> _setupWindowSize() async {
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      await DesktopWindow.setWindowSize(const Size(720, 680));
      await DesktopWindow.setMinWindowSize(const Size(720, 680));
    }
  }

  /// 设置 image 缓存策略
  void setupImageCachePolicy() {
    PaintingBinding.instance.imageCache.maximumSize = 2000; // 最多 2000 张
    PaintingBinding.instance.imageCache.maximumSizeBytes = 200 << 20; // 最大 200M
  }

  /// run zone
  Future<void> _runZone(Widget app) async {
    await runZonedGuarded(
      () async {
        // FlutterBugly.postCatchedException(() {
        debugRepaintRainbowEnabled =
            false; // 开启 debugRepaintRainbowEnabled 时，当重新绘制时，该区域的颜色会发生变化
        WidgetsFlutterBinding.ensureInitialized()
            .addTimingsCallback(onReportTimings); // 设置帧回调函数
        await _setupWindowSize();
        await setSystemUi();
        await Hive.initFlutter();
        await initServices();
        setDebugPrint();
        setupImageCachePolicy();
        setFlutterFrameworkError();

        runApp(app);
        // });
      },
      (error, stackTrace) {
        // 全局异常
        Log.e(error.toString(), stackTrace);
      },
    );
  }

  Future<void> run(Widget app) async {
    await _runZone(app);
  }
}
