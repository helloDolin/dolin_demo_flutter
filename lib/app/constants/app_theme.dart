import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';

class AppTheme {
  static ThemeData dark = ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme().copyWith(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        color: Colors.black,
      ));
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
        elevation: 0.5.h,
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
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
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
