import 'package:flutter/material.dart';
import 'dart:async';

int exceptionCount = 0;
Future<Null> reportError(dynamic error, dynamic stackTrace) async {
  exceptionCount++; //累加异常次数
}

int totalPV = 0;

class MyObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    totalPV++; // 累加PV
  }
}

// 页面异常率
double pageException() {
  if (totalPV == 0) return 0;
  return exceptionCount / totalPV;
}
