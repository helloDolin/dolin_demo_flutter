import 'package:dolin_demo_flutter/app/util/dlapp_defend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/constants/constants.dart';
import 'app/routes/app_pages.dart';
import 'app/util/translation_tool.dart';
import 'global.dart';
import 'dart:ui' as ui;

void main() {
  DLAPPDefend().run(ScreenUtilInit(
      designSize: const Size(375, 667), // iPhone 6，4.7英寸，750*1334 分辨率
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            // showPerformanceOverlay: true,
            debugShowCheckedModeBanner: false,
            title: "dolin_demo_flutter",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            navigatorObservers: [Global.routerObserver],
            // 本地化
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            translations: Messages(), // 你的翻译
            locale: ui.window.locale, // 将会按照此处指定的语言翻译
            fallbackLocale:
                const Locale('en', 'US'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在
            supportedLocales: const [
              Locale('zh', 'CH'),
              Locale('en', 'US'),
            ],
            themeMode: ThemeMode.system,
            darkTheme: AppTheme.dark,
            theme: AppTheme.light);
      }));
}
