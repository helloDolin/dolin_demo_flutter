// ignore_for_file: avoid_dynamic_calls

import 'dart:async';

import 'package:flutter/foundation.dart';

extension FunctionExt on Function {
  // 节流
  // 节流是在事件触发时，立即执行事件的目标操作逻辑，在当前事件未执行完成时，该事件再次触发时会被忽略，直到当前事件执行完成后下一次事件触发才会被执行。
  // 如数据提交等，可有效防止数据的重复提交
  VoidCallback throttle() {
    return FunctionProxy(this).throttle;
  }

  // 指定时间节流
  // 按指定时间节流是在事件触发时，立即执行事件的目标操作逻辑，但在指定时间内再次触发事件会被忽略，直到指定时间后再次触发事件才会被执行。
  VoidCallback throttleWithTimeout({int? timeout}) {
    return FunctionProxy(this, timeout: timeout).throttleWithTimeout;
  }

  // 防抖
  // 防抖是在事件触发时，不立即执行事件的目标操作逻辑，而是延迟指定时间再执行，如果该时间内事件再次触发，则取消上一次事件的执行并重新计算延迟时间，直到指定时间内事件没有再次触发时才执行事件的目标操作。
  // 如滚动监听、输入框输入监听等，可实现滚动停止间隔多久后触发事件的操作或输入框输入变化停止多久后触发事件的操作
  VoidCallback debounce({int? timeout}) {
    return FunctionProxy(this, timeout: timeout).debounce;
  }
}

// 用一个对象来代理执行事件,防止用传入的方式，导致传入的函数 hashCode 每次都一样
class FunctionProxy {
  FunctionProxy(this.target, {int? timeout}) : timeout = timeout ?? 500;
  static final Map<String, bool> _funcThrottle = {};
  static final Map<String, Timer> _funcDebounce = {};
  final Function? target;

  final int timeout;

  Future<void> throttle() async {
    final String key = hashCode.toString();
    final bool enable = _funcThrottle[key] ?? true;
    if (enable) {
      _funcThrottle[key] = false;
      try {
        await target?.call();
      } catch (e) {
        rethrow;
      } finally {
        _funcThrottle.remove(key);
      }
    }
  }

  void throttleWithTimeout() {
    final String key = hashCode.toString();
    final bool enable = _funcThrottle[key] ?? true;
    if (enable) {
      _funcThrottle[key] = false;
      Timer(Duration(milliseconds: timeout), () {
        _funcThrottle.remove(key);
      });
      target?.call();
    }
  }

  void debounce() {
    final String key = hashCode.toString();
    Timer? timer = _funcDebounce[key];
    timer?.cancel();
    timer = Timer(Duration(milliseconds: timeout), () {
      final Timer? t = _funcDebounce.remove(key);
      t?.cancel();
      target?.call();
    });
    _funcDebounce[key] = timer;
  }
}
