import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

/// 计时状态
enum TimeKeepStatus {
  /// 初始态
  none,

  /// 已停止
  stopped,

  /// 运行中
  running,
}

/// 计时模型
class TimeRecordModel {
  /// 当前时刻
  final Duration record;

  /// 与上一时刻的差值
  final Duration addition;

  const TimeRecordModel({
    required this.record,
    required this.addition,
  });
}

class TimeKeepingController extends GetxController {
  Rx<TimeKeepStatus> timeKeepStatus = TimeKeepStatus.none.obs;
  Rx<Duration> duration = Duration.zero.obs;
  RxList<TimeRecordModel> records = <TimeRecordModel>[].obs;

  late Ticker _ticker;

  Duration timeDifference = Duration.zero;
  Duration lastDuration = Duration.zero;

  bool get none => timeKeepStatus.value == TimeKeepStatus.none;
  bool get stopped => timeKeepStatus.value == TimeKeepStatus.stopped;
  bool get running => timeKeepStatus.value == TimeKeepStatus.running;

  Color activeColor = const Color(0xff3A3A3A);
  Color inactiveColor = const Color(0xffDDDDDD);
  Color get resetColor => stopped ? activeColor : inactiveColor; // 重置颜色
  Color get flagColor => running ? activeColor : inactiveColor; // 记录颜色

  /// 启动 or 暂停
  void onTaggle() {
    if (none) {
      timeKeepStatus.value = TimeKeepStatus.running;
      _ticker.start();
    } else if (stopped) {
      timeKeepStatus.value = TimeKeepStatus.running;
      _ticker.start();
    } else if (running) {
      if (_ticker.isTicking) {
        _ticker.stop();
        lastDuration = Duration.zero;
      }
      timeKeepStatus.value = TimeKeepStatus.stopped;
    }
  }

  /// 重置
  void onReset() {
    timeKeepStatus.value = TimeKeepStatus.none;
    duration.value = Duration.zero;
    records.clear();
  }

  /// 记录
  void onRecoder() {
    Duration current = duration.value;
    Duration addition = duration.value;
    if (records.isNotEmpty) {
      addition = Duration.zero - records.last.record;
    }
    records.add(TimeRecordModel(record: current, addition: addition));
  }

  /// duration 转字符串
  String durationToString(Duration duration) {
    int minus = duration.inMinutes % 60;
    int second = duration.inSeconds % 60;
    int milliseconds = duration.inMilliseconds % 1000;
    String commonStr =
        '${minus.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}';
    String highlightStr = ".${(milliseconds ~/ 10).toString().padLeft(2, "0")}";
    return commonStr + highlightStr;
  }

  @override
  void onInit() {
    // timeKeepStatus.value = TimeKeepStatus.none;
    super.onInit();
  }

  @override
  void onReady() {
    // elapsed:消逝、时间的流逝
    _ticker = Ticker((elapsed) {
      timeDifference = elapsed - lastDuration;
      duration.value += timeDifference;
      lastDuration = elapsed;
    });
    super.onReady();
  }

  @override
  void onClose() {
    _ticker.dispose();
    super.onClose();
  }
}
