import 'package:dolin/app/services/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:logger_flutter_plus/logger_flutter_plus.dart';

class Log {
  static Logger logger = Logger(
    output: AppLogOutput(
      logConsoleManager: StorageService.instance.logConsoleManager,
    ),
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: true,
    ),
  );

  /// Debug log
  static void d(String message) {
    logger.d('${DateTime.now()}\n$message');
  }

  /// Info log
  static void i(String message) {
    logger.i('${DateTime.now()}\n$message');
  }

  /// Error log
  static void e(String message, StackTrace stackTrace) {
    logger.e('${DateTime.now()}\n$message', null, stackTrace);
  }

  /// Warning log
  static void w(String message) {
    logger.w('${DateTime.now()}\n$message');
  }

  static void logPrint(dynamic obj) {
    if (obj is Error) {
      Log.e(obj.toString(), obj.stackTrace ?? StackTrace.current);
    } else if (kDebugMode) {
      print(obj);
    }
  }
}

class AppLogOutput extends LogOutput {
  AppLogOutput({
    required this.logConsoleManager,
  });
  final LogConsoleManager logConsoleManager;

  @override
  void output(OutputEvent event) {
    // 记录到 logConsoleManager
    logConsoleManager.addLog(event);
    // 控制台打印
    event.lines.forEach(debugPrint);
  }

  @override
  void destroy() {
    logConsoleManager.dispose();
    super.destroy();
  }
}
