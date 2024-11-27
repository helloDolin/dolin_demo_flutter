```dart
// 多 hosts 切换

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_module/flavors/build_config.dart';

class DynamicHostInterceptor extends Interceptor {
  // http 层挂掉(非 200 - 300 之间),更换 host
  bool _shouldRetry(int statusCode) {
    return statusCode < 200 || statusCode >= 300;
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final List<String> hosts = BuildConfig.instance.config.hostList;
    final statusCode = err.response?.statusCode;
    if (_shouldRetry(statusCode ?? -1)) {
      bool requestSuccessful = false;
      for (int i = 0; i < hosts.length; i++) {
        try {
          // 重新发起请求
          final retryOptions = err.requestOptions..baseUrl = hosts[i];
          debugPrint('host - - ${hosts[i]}');
          final response = await Dio().fetch(retryOptions);
          handler.resolve(response);
          BuildConfig.instance.config.baseUrl = hosts[i];
          requestSuccessful = true;
          break;
        } catch (e) {
          debugPrint(e.toString());
          // 如果请求失败，则继续尝试下一个host
          continue;
        }
      }

      if (!requestSuccessful) {
        handler.next(err);
      }
      return;
    }

    handler.next(err);
  }
}
```