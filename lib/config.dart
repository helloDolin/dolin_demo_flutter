import 'package:dolin_demo_flutter/pages/bloc_practice/blocPage.dart';
import 'package:flutter/material.dart';
import 'package:dolin_demo_flutter/pages/arena.dart';
import 'package:dolin_demo_flutter/pages/async+provider.dart';
import 'package:dolin_demo_flutter/pages/customPaint.dart';
import 'package:dolin_demo_flutter/pages/home.dart';
import 'package:dolin_demo_flutter/pages/scrollView.dart';
import 'package:dolin_demo_flutter/pages/yield_study/page.dart' as yield_study;

// 路由表实际上是一个 Map<String,WidgetBuilder>
final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomePage(),
  '/scrollViewPage': (context) => const ScrollViewPage(),
  '/customPaintPage': (context) => const CustomPaintPage(),
  '/arenaPage': (context) => const ArenaPage(),
  '/async+provider': (context) => const AsyncPage(),
  '/blocPage': (context) => const BlocPage(),
  '/yiledStudy': (context) => const yield_study.Page(),
};
