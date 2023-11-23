// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:dolin/app/https/custom_error.dart';
import 'package:dolin/app/https/custom_interceptor.dart';
import 'package:dolin/app/services/user.dart';
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

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool isShowLoading = true,
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
      if (e.type == DioErrorType.cancel) {
        rethrow;
      }
      if (e.type == DioErrorType.badResponse) {
        throw CustomError(message: '请求失败:${e.response?.statusCode ?? -1}');
      }
      throw CustomError(
        message: '请求失败,请检查网络',
      );
    }
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
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
      if (e.type == DioErrorType.cancel) {
        rethrow;
      }
      if (e.type == DioErrorType.badResponse) {
        throw CustomError(message: '请求失败:${e.response?.statusCode ?? -1}');
      }
      throw CustomError(message: '请求失败,请检查网络');
    }
  }
}
