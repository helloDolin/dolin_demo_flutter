import 'package:dolin_demo_flutter/app/util/dlapp_defend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/constants/constants.dart';
import 'app/routes/app_pages.dart';

void main() {
  DLAPPDefend().run(ScreenUtilInit(
      designSize: const Size(1080, 2400), // 设计搞中的宽高
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            // showPerformanceOverlay: true,
            debugShowCheckedModeBanner: false,
            title: "dolin_demo_flutter",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
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
            theme: AppTheme.light);
      }));
}
