import 'package:intl/intl.dart';

class TimeUtil {
  static DateFormat ymdFormat = DateFormat('yyyy-MM-dd');
  static DateFormat mdhmFormat = DateFormat('MM-dd HH:mm');
  static DateFormat ymdhmFormat = DateFormat('yyyy-MM-dd HH:mm');
  static DateFormat ymdhmsFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  /// 时间戳格式化-秒
  static String formatTimestampS(int ts) {
    if (ts == 0) {
      return '----';
    }
    return formatTimestampMS(ts * 1000);
  }

  /// 时间戳格式化-毫秒
  static String formatTimestampMS(int ts) {
    final dt = DateTime.fromMillisecondsSinceEpoch(ts);

    final dtNow = DateTime.now();
    if (dt.year == dtNow.year &&
        dt.month == dtNow.month &&
        dt.day == dtNow.day) {
      return "今天${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    }
    if (dt.year == dtNow.year &&
        dt.month == dtNow.month &&
        dt.day == dtNow.day - 1) {
      return "昨天${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    }

    if (dt.year == dtNow.year) {
      return mdhmFormat.format(dt);
    }

    return ymdhmsFormat.format(dt);
  }
}
