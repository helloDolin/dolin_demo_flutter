// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:dolin/app/services/user.dart';
import 'package:get/get.dart' hide FormData, Response;

import 'custom_error.dart';
import 'custom_interceptor.dart';

// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
class HttpsClient {
  /// 工厂构造函数
  factory HttpsClient() => _instance;

  /// 单例
  static final HttpsClient _instance = HttpsClient._internal();
  static HttpsClient get instance => _instance;
  late Dio _dio;

  /// 构造函数私有化，防止被误创建
  HttpsClient._internal() {
    final BaseOptions options = BaseOptions(
      // baseUrl: 'https://api.wmdb.tv/api/v1/top',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
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

  /// 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};

    if (Get.isRegistered<UserStore>() && UserStore.to.hasToken == true) {
      headers['Authorization'] = 'DOLIN-${UserStore.to.token}';
    } else {
      // 登录
      // Get.toNamed(Routes.LOGIN);
    }
    return headers;
  }

  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      bool isShowLoading = true}) async {
    try {
      Options requestOptions = options ?? Options();
      requestOptions.headers = requestOptions.headers ?? {};
      Map<String, dynamic>? authorization = getAuthorizationHeader();
      if (authorization != null) {
        requestOptions.headers!.addAll(authorization);
      }
      // if (isShowLoading) {
      //   EasyLoading.show(dismissOnTap: true);
      // }
      final Response<dynamic> res = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return res.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.cancel) {
        rethrow;
      }
      if (e.type == DioErrorType.badResponse) {
        return throw CustomError(
            message: '请求失败:${e.response?.statusCode ?? -1}');
      }
      throw CustomError(
        message: "请求失败,请检查网络",
      );
    }
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      Options requestOptions = options ?? Options();
      requestOptions.headers = requestOptions.headers ?? {};
      Map<String, dynamic>? authorization = getAuthorizationHeader();
      if (authorization != null) {
        requestOptions.headers!.addAll(authorization);
      }
      final Response<dynamic> res = await _dio.post(
        path,
        data: queryParameters,
        options: requestOptions,
      );
      return res.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.cancel) {
        rethrow;
      }
      if (e.type == DioErrorType.badResponse) {
        return throw CustomError(
            message: '请求失败:${e.response?.statusCode ?? -1}');
      }
      throw CustomError(message: "请求失败,请检查网络");
    }
  }
}
