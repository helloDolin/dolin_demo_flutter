// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:dolin/app/https/custom_error.dart';
import 'package:dolin/app/https/custom_interceptor.dart';
import 'package:dolin/app/services/user.dart';
import 'package:dolin/app/util/toast_util.dart';
import 'package:get/get.dart' hide FormData, Response;

// 单例参考官方例子：
// https://flutter.cn/community/tutorials/singleton-pattern-in-flutter-n-dart

// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
class HttpsClient {
  factory HttpsClient() => _instance; // 工厂构造函数 （具备了 不必每次都去创建新的类实例 的特性）

  /// 构造函数私有化，防止被误创建
  HttpsClient._internal() {
    final BaseOptions options = BaseOptions(
      // baseUrl: 'https://api.wmdb.tv/api/v1/top',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      // 公共数据，eg：token、version、timestamp、sign、platform、channel
      headers: <String, dynamic>{},
      contentType: 'application/json; charset=utf-8',
      // responseType: ResponseType.json,
    );
    _dio = Dio(options);
    // Cookie管理
    // CookieJar cookieJar = CookieJar();
    // _dio.interceptors.add(CookieManager(cookieJar));
    _dio.interceptors.add(CustomInterceptor());
  }
  // HttpsClient._internal();

  static final HttpsClient _instance = HttpsClient._internal();

  static HttpsClient get instance => _instance;

  late Dio _dio;

  /// 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    final headers = <String, dynamic>{};

    if (Get.isRegistered<UserStore>() && UserStore.to.hasToken == true) {
      headers['Authorization'] = 'DOLIN-${UserStore.to.token}';
    } else {
      // 登录
      // Get.toNamed(Routes.LOGIN);
    }
    return headers;
  }

  void handleError(CustomError err, {bool isShowErrorToast = true}) {
    handleErrorCode(err.code);
    if (isShowErrorToast && err.message.isNotEmpty) {
      showToast(err.message);
    }
  }

  /// 处理错误 code
  /// 与服务端协商的 code
  void handleErrorCode(int code) {
    switch (code) {
      case 401:
        UserStore.to.onLogout();
      default:
        break;
    }
  }

  /// 创建自定义错误
  CustomError createCustomError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return CustomError(code: -1, message: '请求取消');
      case DioErrorType.connectionTimeout:
        return CustomError(code: -1, message: '连接超时');
      case DioErrorType.sendTimeout:
        return CustomError(code: -1, message: '请求超时');
      case DioErrorType.receiveTimeout:
        return CustomError(code: -1, message: '响应超时');
      case DioErrorType.unknown:
        return CustomError(
          code: error.response?.statusCode ?? -1,
          message: error.message ?? '',
        );
      case DioErrorType.badResponse:
        {
          try {
            final errCode =
                error.response != null ? error.response!.statusCode! : -1;
            // String errMsg = error.response.statusMessage;
            // return CustomError(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                return CustomError(code: errCode, message: '请求语法错误');
              case 401:
                return CustomError(code: errCode, message: '没有权限');
              case 403:
                return CustomError(code: errCode, message: '服务器拒绝执行');
              case 404:
                return CustomError(code: errCode, message: '无法连接服务器');
              case 405:
                return CustomError(code: errCode, message: '请求方法被禁止');
              case 500:
                return CustomError(code: errCode, message: '服务器内部错误');
              case 502:
                return CustomError(code: errCode, message: '无效的请求');
              case 503:
                return CustomError(code: errCode, message: '服务器挂了');
              case 505:
                return CustomError(code: errCode, message: '不支持HTTP协议请求');
              default:
                {
                  // return CustomError(code: errCode, message: "未知错误");
                  return CustomError(
                    code: errCode,
                    message: error.response != null
                        ? error.response!.statusMessage!
                        : '',
                  );
                }
            }
          } on Exception catch (_) {
            return CustomError(code: -1, message: '未知错误');
          }
        }
      // ignore: no_default_cases
      default:
        {
          return CustomError(code: -1, message: error.message ?? '');
        }
    }
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool isShowLoading = true,
    bool isShowErrorToast = true,
  }) async {
    try {
      final requestOptions = options ?? Options();
      requestOptions.headers = requestOptions.headers ?? {};
      final authorization = getAuthorizationHeader();
      if (authorization != null) {
        requestOptions.headers!.addAll(authorization);
      }

      // if (isShowLoading) {
      //   EasyLoading.show(dismissOnTap: true);
      // }
      final res = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return res.data;
    } on DioError catch (e) {
      handleError(createCustomError(e), isShowErrorToast: isShowErrorToast);
    }
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool isShowErrorToast = true,
  }) async {
    try {
      final requestOptions = options ?? Options();
      requestOptions.headers = requestOptions.headers ?? {};
      final authorization = getAuthorizationHeader();
      if (authorization != null) {
        requestOptions.headers!.addAll(authorization);
      }
      final res = await _dio.post<dynamic>(
        path,
        data: queryParameters,
        options: requestOptions,
      );
      return res.data;
    } on DioError catch (e) {
      handleError(createCustomError(e), isShowErrorToast: isShowErrorToast);
    }
  }
}
