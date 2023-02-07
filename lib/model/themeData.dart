// ignore_for_file: file_names

import 'package:flutter/material.dart';

// iOS 浅色主题
final ThemeData kIOSTheme = ThemeData(
    brightness: Brightness.light, // 亮色主题
    primarySwatch: Colors.blueGrey, // 导航栏颜色
    primaryColor: Colors.blue, // 主题色为蓝色
    iconTheme: const IconThemeData(color: Colors.grey), //icon 主题为灰色
    textTheme: const TextTheme(
        bodyText2: TextStyle(color: Colors.black, fontSize: 16)) // 文本主题为红色
    );

// Android 深色主题
final ThemeData kAndroidTheme = ThemeData(
    brightness: Brightness.dark, // 深色主题
    primaryColor: Colors.cyan, // 主题色 Wie 青色
    iconTheme: const IconThemeData(color: Colors.blue), //icon 主题色为蓝色
    textTheme:
        const TextTheme(bodyText2: TextStyle(color: Colors.red)) // 文本主题色为红色
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
    brightness: Brightness.dark, // 明暗模式为暗色
    primarySwatch: Colors.cyan, // 导航栏颜色
    primaryColor: Colors.cyan, // 主色调为青色
    iconTheme: const IconThemeData(color: Colors.yellow), // 设置 icon 主题色为黄色
    textTheme:
        const TextTheme(bodyText2: TextStyle(color: Colors.red)) // 设置文本颜色为红色
    );
