import 'dart:async';

import 'package:dolin/app/modules/debug/log/log.dart';
import 'package:flutter/material.dart';

int exceptionCount = 0;
Future<void> reportError(dynamic error, dynamic stackTrace) async {
  exceptionCount++; //累加异常次数
}

int totalPV = 0;

class MyObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    totalPV++; // 累加PV
  }
}

// 页面异常率
double pageException() {
  if (totalPV == 0) return 0;
  Log.w((exceptionCount / totalPV).toString());
  return exceptionCount / totalPV;
}
