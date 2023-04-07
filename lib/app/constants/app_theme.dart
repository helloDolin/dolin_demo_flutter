import 'package:dolin_demo_flutter/app/util/screenAdapter.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static const horizontalMargin = 16.0;
  static const radius = 10.0;

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.scaffoldBackground,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: AppColor.accentColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColor.accentColor,
    ),
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: AppColor.primaryText),
        centerTitle: true,
        color: Colors.white,
        elevation: ScreenAdapter.height(0.5),
        titleTextStyle: const TextStyle(
          color: AppColor.primaryText,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        toolbarTextStyle: const TextStyle(
          color: AppColor.primaryText,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.scaffoldBackground,
      unselectedLabelStyle: TextStyle(fontSize: 12),
      selectedLabelStyle: TextStyle(fontSize: 12),
      unselectedItemColor: Color(0xffA2A5B9),
      selectedItemColor: AppColor.accentColor,
    ),
    tabBarTheme: const TabBarTheme(
      // indicatorSize: TabBarIndicatorSize.label,
      labelColor: AppColor.accentColor,
      unselectedLabelColor: AppColor.secondaryText,
    ),
  );
}
