import 'package:dolin_demo_flutter/app/util/dlapp_defend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'app/constants/constants.dart';
import 'app/language/translation_service.dart';
import 'app/modules/unknowPage.dart';
import 'app/routes/app_pages.dart';
import 'global.dart';

void main() {
  DLAPPDefend().run(ScreenUtilInit(
      designSize: const Size(375, 667), // iPhone 6，4.7英寸，750*1334 分辨率
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return RefreshConfiguration(
          headerBuilder: () => const ClassicHeader(),
          footerBuilder: () => const ClassicFooter(),
          headerTriggerDistance: 80, // 头部触发刷新的越界距离
          maxOverScrollExtent: 100, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
          footerTriggerDistance: 150, // 底部最大可以拖动的范围
          enableScrollWhenRefreshCompleted:
              true, //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
          enableLoadingWhenFailed: true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
          hideFooterWhenNotFull: true, // Viewport不满一屏时,禁用上拉加载更多功能
          enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多

          springDescription: const SpringDescription(
              stiffness: 170,
              damping: 16,
              mass: 1.9), // 自定义回弹动画,三个属性值意义请查询flutter api

          child: GetMaterialApp(
            // showPerformanceOverlay: true,
            debugShowCheckedModeBanner: false,
            title: "dolin_demo_flutter",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            navigatorObservers: [Global.routerObserver, GetXRouterObserver()],
            // 本地化
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            translations: Messages(), // 你的翻译
            locale: Get.deviceLocale, // ui.window.locale, // 将会按照此处指定的语言翻译
            fallbackLocale:
                const Locale('en', 'US'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在
            supportedLocales: const [
              Locale('zh', 'CH'),
              Locale('en', 'US'),
            ],
            themeMode: ThemeMode.system,
            darkTheme: AppTheme.dark,
            theme: AppTheme.light,
            unknownRoute: GetPage(name: '/404', page: () => const UnknowPage()),
            enableLog: true,
            logWriterCallback: write,
          ),
        );
      }));
}

void write(String text, {bool isError = false}) {
  Future.microtask(() => print('** $text. isError: [$isError]'));
}
