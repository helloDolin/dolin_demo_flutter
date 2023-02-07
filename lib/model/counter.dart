// 定义需要共享的数据模型，通过混入 ChangeNotifier 管理听众
import 'package:flutter/material.dart';

class CounterModel with ChangeNotifier {
  int _count = 0;
  // 读方法
  int get counter => _count;
  // 写方法
  void increment() {
    _count++;
    notifyListeners(); // 通知听众刷新
  }
}
