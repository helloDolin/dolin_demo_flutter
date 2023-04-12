import 'package:dolin_demo_flutter/app/util/dlapp_defend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/constants/constants.dart';
import 'app/routes/app_pages.dart';
import 'global.dart';

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
            // 国际化
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('zh', 'CH'),
              Locale('en', 'US'),
            ],
            themeMode: ThemeMode.system,
            darkTheme: AppTheme.dark,
            theme: AppTheme.light);
      }));
}
