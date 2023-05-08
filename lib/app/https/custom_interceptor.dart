import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../services/user.dart';
import '../util/log.dart';
import 'custom_error.dart';

/// 自定义拦截器
class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['ts'] = DateTime.now().millisecondsSinceEpoch;
    options.headers['lang'] = '${Get.locale}';
    options.headers['Authorization'] = 'DOLIN ${UserStore.to.token}';
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final time = DateTime.now().millisecondsSinceEpoch -
        response.requestOptions.extra["ts"];
    Log.i(
      '''【HTTP请求响应】 耗时:${time}ms
Request Method：${response.requestOptions.method}
Request Code：${response.statusCode}
Request URL：${response.requestOptions.uri}
Request Query：${response.requestOptions.queryParameters}
Request Data：${response.requestOptions.data}
Request Headers：${response.requestOptions.headers}
Response Headers：${response.headers.map}
Response Data：${response.data}''',
    );

    //  返回数据结构、内容校验
    // final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    // if (data['code'] == null || data['msg'] == null || data['data'] == null) {
    //   // EasyLoading.showError('data format error: $data');
    // }

    // data['code'] = data['code'] ?? -1;
    // data['data'] = data['data'] ?? <dynamic, dynamic>{};

    // final int code = data['code'] as int;
    // if (code == 0) {
    //   handler.next(response);
    // } else {
    //   if (!handleErrorCode(code)) {
    //     handler.reject(DioError(
    //         requestOptions: response.requestOptions,
    //         response: Response(
    //           requestOptions: response.requestOptions,
    //           statusCode: code,
    //         )));
    //   }
    // }
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final time =
        DateTime.now().millisecondsSinceEpoch - err.requestOptions.extra['ts'];
    Log.e('''【HTTP请求错误】 耗时:${time}ms
Request Method：${err.requestOptions.method}
Response Code：${err.response?.statusCode}
Request URL：${err.requestOptions.uri}
Request Query：${err.requestOptions.queryParameters}
Request Data：${err.requestOptions.data}
Request Headers：${err.requestOptions.headers}
Response Headers：${err.response?.headers.map}
Response Data：${err.response?.data}''', err.stackTrace);

    final CustomError customErr = createCustomError(err);
    handleErrorCode(customErr.code);
    return handler.next(err);
  }
}

bool handleErrorCode(int code) {
  bool res = true;
  switch (code) {
    case 401:
      UserStore.to.onLogout();
      break;
    default:
      res = false;
      break;
  }
  return res;
}

// 错误信息
CustomError createCustomError(DioError error) {
  switch (error.type) {
    case DioErrorType.cancel:
      return CustomError(code: -1, message: "请求取消");
    case DioErrorType.connectionTimeout:
      return CustomError(code: -1, message: "连接超时");
    case DioErrorType.sendTimeout:
      return CustomError(code: -1, message: "请求超时");
    case DioErrorType.receiveTimeout:
      return CustomError(code: -1, message: "响应超时");
    case DioErrorType.badResponse:
      {
        try {
          int errCode =
              error.response != null ? error.response!.statusCode! : -1;
          // String errMsg = error.response.statusMessage;
          // return CustomError(code: errCode, message: errMsg);
          switch (errCode) {
            case 400:
              return CustomError(code: errCode, message: "请求语法错误");
            case 401:
              return CustomError(code: errCode, message: "没有权限");
            case 403:
              return CustomError(code: errCode, message: "服务器拒绝执行");
            case 404:
              return CustomError(code: errCode, message: "无法连接服务器");
            case 405:
              return CustomError(code: errCode, message: "请求方法被禁止");
            case 500:
              return CustomError(code: errCode, message: "服务器内部错误");
            case 502:
              return CustomError(code: errCode, message: "无效的请求");
            case 503:
              return CustomError(code: errCode, message: "服务器挂了");
            case 505:
              return CustomError(code: errCode, message: "不支持HTTP协议请求");
            default:
              {
                // return CustomError(code: errCode, message: "未知错误");
                return CustomError(
                  code: errCode,
                  message: error.response != null
                      ? error.response!.statusMessage!
                      : "",
                );
              }
          }
        } on Exception catch (_) {
          return CustomError(code: -1, message: "未知错误");
        }
      }
    default:
      {
        return CustomError(code: -1, message: error.message ?? '');
      }
  }
}
