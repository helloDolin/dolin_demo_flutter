import 'package:dio/dio.dart';
import 'package:dolin/app/modules/debug/log/log.dart';
import 'package:get/get.dart' hide Response;

// handler.resolve(response) 返回自定义响应
// handler.reject(error) 返回自定义错误

/// 自定义拦截器
class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['ts'] = DateTime.now().millisecondsSinceEpoch;
    options.headers['lang'] = '${Get.locale}';
    // options.headers['Authorization'] = 'DOLIN ${UserStore.to.token}'; 发起请求的时候塞进 header
    handler.next(options); // 请求继续
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final int time = getTimeElapsed(response.requestOptions);
    logResponse(time, response);
    if (response.data is! Map<String, dynamic>) {
      handler.next(response);
      return;
    }

    // 返回数据结构校验
    final Map<String, dynamic>? data = response.data as Map<String, dynamic>?;
    if (data != null) {
      if (data['code'] == null || data['msg'] == null || data['data'] == null) {
        // 非 code msg data 结构,看是否需要校验
        // EasyLoading.showError('data format error: $data');
      }

      final int? code = data['code'] as int?;
      final String? msg = data['msg'] as String?;
      if (code == 0) {
        handler.next(response);
        return;
      } else if (code != null) {
        handler.reject(
          DioError(
            requestOptions: response.requestOptions,
            response: Response(
              requestOptions: response.requestOptions,
              statusCode: code,
            ),
            message: (msg != null && msg.isNotEmpty) ? msg : '',
          ),
        );
        return;
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final int time = getTimeElapsed(err.requestOptions);
    logError(time, err);
    handler.next(err);
  }
}

/// 获取时间差
int getTimeElapsed(RequestOptions options) {
  final ts = options.extra['ts'] as int?;
  return ts != null ? DateTime.now().millisecondsSinceEpoch - ts : -1;
}

/// 记录响应日志
void logResponse(int time, Response<dynamic> response) {
  Log.i('''
【HTTP请求响应】 耗时:${time}ms
Request Method：${response.requestOptions.method}
Request Code：${response.statusCode}
Request URL：${response.requestOptions.uri}
Request Query：${response.requestOptions.queryParameters}
Request Data：${response.requestOptions.data}
Request Headers：${response.requestOptions.headers}
Response Headers：${response.headers.map}
Response Data：${response.data}''');
}

/// 记录错误日志
void logError(int time, DioError err) {
  Log.e(
    '''
【HTTP请求错误】 耗时:${time}ms
Request Method：${err.requestOptions.method}
Response Code：${err.response?.statusCode}
Request URL：${err.requestOptions.uri}
Request Query：${err.requestOptions.queryParameters}
Request Data：${err.requestOptions.data}
Request Headers：${err.requestOptions.headers}
Response Headers：${err.response?.headers.map}
Response Data：${err.response?.data}''',
    err.stackTrace,
  );
}
