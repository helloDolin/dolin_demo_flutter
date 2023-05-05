import 'dart:developer' as developer;

// import 'package:intl/intl.dart';

// import '../app_export.dart';

// // 枚举 用于区分不同级别的日志
// enum LogLevel { dev, info, warn, error }

// // ignore: avoid_classes_with_only_static_members
// class Logger {
//   static final RxList<RxString> logs = <RxString>[].obs;
//   static final RxString logCurrent = ''.obs;

//   static void log(
//     String message, {
//     String? tag = 'dev',
//     LogLevel? logLevel = LogLevel.dev,
//     bool? show = false,
//   }) {
//     message =
//         '${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}\n tag:$tag\n $message\n';
//     developer.log(message, name: tag ?? 'dev');
//     logs.add(RxString(message));
//     logCurrent.value = message;
//     if (logs.length > 500) {
//       logs.removeRange(0, 50);
//     }

//     if (show ?? false) {
//       // message最长100字符，超过截断
//       if (message.length > 100) {
//         message = message.substring(0, 99);
//       }
//       // Get.snackbar('error', message);

//       // EasyLoading.showError(message,
//       //     duration: const Duration(seconds: 3), dismissOnTap: true);
//       // EasyLoading.show(
//       //   status: message,
//       //   maskType: EasyLoadingMaskType.black,
//       //   dismissOnTap: true,
//       // );
//     }

//     // if (logLevel == LogLevel.error) {
//     //   EasyLoading.show(
//     //     status: message,
//     //     maskType: EasyLoadingMaskType.black,
//     //   );
//     // }

//     // if (!kReleaseMode) {
//     //   message =
//     //       '${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}\n $message';
//     //   debugPrint(message);
//     //   logs.add(RxString(message));
//     //   logCurrent.value = message;
//     //   if (logs.length > 200) {
//     //     logs.removeRange(0, 20);
//     //   }
//     // }
//   }

//   static LogMode _logMode = LogMode.debug;

//   LogMode get logMode => _logMode;

//   set logMode(LogMode mode) {
//     Logger._logMode = mode;
//   }
// }

// enum LogMode { debug, live }
