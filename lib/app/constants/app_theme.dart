import 'package:dolin/app/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:underline_indicator/underline_indicator.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColor.accentColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: AppColor.accentColor,
    appBarTheme: AppBarTheme(
      elevation: 0.5,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      centerTitle: true,
      shape: Border(
        bottom: BorderSide(
          color: Colors.grey.withOpacity(.2),
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColor.primaryText,
      ),
      titleTextStyle: const TextStyle(
        color: AppColor.primaryText,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      toolbarTextStyle: const TextStyle(
        color: AppColor.primaryText,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: Colors.transparent,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.scaffoldBackground,
      unselectedLabelStyle: TextStyle(fontSize: 10),
      selectedLabelStyle: TextStyle(fontSize: 12),
      unselectedItemColor: Color(0xffA2A5B9),
      selectedItemColor: Colors.black,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black, // 选中Tab的文字颜色
      unselectedLabelColor: AppColor.secondaryText, // 未选中Tab的文字颜色
      labelStyle: TextStyle(fontSize: 16), // 选中Tab的文字样式
      unselectedLabelStyle: TextStyle(fontSize: 14), // 未选中Tab的文字样式
      indicator: UnderlineIndicator(
        borderSide: BorderSide(
          width: 2,
        ),
      ),
      indicatorColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.label, // 指示器大小为 label 大小
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    dividerColor: Colors.black,
    // textTheme: const TextTheme(
    //   displayMedium: TextStyle(color: Color(0xff333333), fontSize: 14),
    // ),
    // 输入框填充色
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Color(0xff333333),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          // 根据组件状态设置值
          (states) => states.contains(MaterialState.disabled)
              ? const Color(0xFF5e5e5e)
              : const Color(0xFF333333),
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.disabled)
              ? const Color(0xFFABABAB)
              : Colors.white,
        ),
        // 定义按钮在被点击时的覆盖颜色
        overlayColor: const MaterialStatePropertyAll(Colors.white10),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        textStyle: const MaterialStatePropertyAll(
          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );

  // ThemeData.dark(useMaterial3: false).copyWith
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.white,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.black.withOpacity(0.5),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: AppColor.secondaryColor,
    appBarTheme: AppBarTheme(
      // elevation: 0.5,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      centerTitle: true,
      // shape: const Border(
      //   bottom: BorderSide(
      //     color: Colors.white,
      //   ),
      // ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      toolbarTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: Colors.transparent,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      unselectedLabelStyle: TextStyle(fontSize: 10),
      selectedLabelStyle: TextStyle(fontSize: 12),
      unselectedItemColor: Color(0xffA2A5B9),
      selectedItemColor: Colors.white,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white, // 选中Tab的文字颜色
      unselectedLabelColor: AppColor.secondaryText, // 未选中Tab的文字颜色
      labelStyle: TextStyle(fontSize: 16), // 选中Tab的文字样式
      unselectedLabelStyle: TextStyle(fontSize: 14), // 未选中Tab的文字样式
      indicator: UnderlineIndicator(
        // ignore: avoid_redundant_argument_values
        borderSide: BorderSide(
          width: 2,
          color: Colors.white,
        ),
      ),
      indicatorColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label, // 指示器大小为 label 大小
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    dividerColor: Colors.white,
    // 主内容文字样式
    textTheme: const TextTheme(
      displayMedium: TextStyle(color: Color(0xffA9B7C6), fontSize: 14),
    ),
    // 输入框填充色
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Color(0xffffffff),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          // 根据组件状态设置值
          (states) => states.contains(MaterialState.disabled)
              ? const Color(0xFF5e5e5e)
              : const Color(0xFFFFFFFF),
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.disabled)
              ? const Color(0xFFABABAB)
              : Colors.black,
        ),
        // 定义按钮在被点击时的覆盖颜色
        overlayColor: const MaterialStatePropertyAll(Colors.white10),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 16, horizontal: 25),
        ),
        shape: const MaterialStatePropertyAll(StadiumBorder()),
        textStyle: const MaterialStatePropertyAll(
          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}
