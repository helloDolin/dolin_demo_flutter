import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dolin_demo_flutter/app/store/user.dart';
import 'package:get/get.dart';

class HttpsClient {
  /// 单例
  static final HttpsClient _instance = HttpsClient._internal();
  static HttpsClient get instance => _instance;
  Dio? _dio;

  /// 工厂构造函数
  factory HttpsClient() {
    return _instance;
  }

  /// 构造函数私有化，防止被误创建
  HttpsClient._internal() {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: 'https://api.wmdb.tv/api/v1/top',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {},
        contentType: 'application/json; charset=utf-8',
        responseType: ResponseType.json,
      );
      _dio = Dio(options);
      // Cookie管理
      CookieJar cookieJar = CookieJar();
      _dio!.interceptors.add(CookieManager(cookieJar));

      // 添加拦截器
      _dio!.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          return handler.next(options); //continue
          // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
          // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
          //
          // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
          // 这样请求将被中止并触发异常，上层catchError会被调用。
        },
        onResponse: (response, handler) {
          // Do something with response data
          return handler.next(response); // continue
          // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
          // 这样请求将被中止并触发异常，上层catchError会被调用。
        },
        onError: (DioError e, handler) {
          // Do something with response error
          // Loading.dismiss();
          ErrorEntity eInfo = createErrorEntity(e);
          onError(eInfo);
          return handler.next(e); //continue
          // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
          // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
        },
      ));
    }
  }

  /*
   * error统一处理
   */

  // 错误处理
  void onError(ErrorEntity eInfo) {
    print('error.code -> ${eInfo.code}, error.message -> ${eInfo.message}');
    switch (eInfo.code) {
      case 401:
        UserStore.to.onLogout();
        // EasyLoading.showError(eInfo.message);
        break;
      default:
        // EasyLoading.showError('未知错误');
        break;
    }
  }

  // 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return ErrorEntity(code: -1, message: "请求取消");
      case DioErrorType.connectionTimeout:
        return ErrorEntity(code: -1, message: "连接超时");
      case DioErrorType.sendTimeout:
        return ErrorEntity(code: -1, message: "请求超时");
      case DioErrorType.receiveTimeout:
        return ErrorEntity(code: -1, message: "响应超时");
      case DioErrorType.badResponse:
        {
          try {
            int errCode =
                error.response != null ? error.response!.statusCode! : -1;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                return ErrorEntity(code: errCode, message: "请求语法错误");
              case 401:
                return ErrorEntity(code: errCode, message: "没有权限");
              case 403:
                return ErrorEntity(code: errCode, message: "服务器拒绝执行");
              case 404:
                return ErrorEntity(code: errCode, message: "无法连接服务器");
              case 405:
                return ErrorEntity(code: errCode, message: "请求方法被禁止");
              case 500:
                return ErrorEntity(code: errCode, message: "服务器内部错误");
              case 502:
                return ErrorEntity(code: errCode, message: "无效的请求");
              case 503:
                return ErrorEntity(code: errCode, message: "服务器挂了");
              case 505:
                return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
              default:
                {
                  // return ErrorEntity(code: errCode, message: "未知错误");
                  return ErrorEntity(
                    code: errCode,
                    message: error.response != null
                        ? error.response!.statusMessage!
                        : "",
                  );
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "未知错误");
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message ?? '');
        }
    }
  }

  /// 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};

    if (Get.isRegistered<UserStore>() && UserStore.to.hasToken == true) {
      headers['Authorization'] = 'DOLIN-${UserStore.to.token}';
    }
    return headers;
  }

  Future get(
    apiUrl, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      Options requestOptions = options ?? Options();
      requestOptions.headers = requestOptions.headers ?? {};
      Map<String, dynamic>? authorization = getAuthorizationHeader();
      if (authorization != null) {
        requestOptions.headers!.addAll(authorization);
      }
      var res =
          await _dio!.get(apiUrl, queryParameters: data, options: options);
      print('''
=============apiUrl=================
${res.realUri}
''');
      return res;
    } catch (e) {
      print('请求超时');
      return null;
    }
  }

  Future post(
    String apiUrl, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      Options requestOptions = options ?? Options();
      requestOptions.headers = requestOptions.headers ?? {};
      Map<String, dynamic>? authorization = getAuthorizationHeader();
      if (authorization != null) {
        requestOptions.headers!.addAll(authorization);
      }
      var res = await _dio!.post(apiUrl, data: data, options: requestOptions);
      print('''
=============apiUrl=================
${res.realUri}
''');
      return res;
    } catch (e) {
      print('请求超时');
      return null;
    }
  }
}

// 异常处理
class ErrorEntity implements Exception {
  int code = -1;
  String message = "";
  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") return "Exception";
    return "Exception: code $code, $message";
  }
}




// ignore_for_file: always_specify_types, avoid_dynamic_calls

// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart' hide FormData, Response;

// import '../../../generated/locales.g.dart';
// import '../../data/models/user.dart';
// import '../../data/providers/apis/apis.dart';
// import '../../routes/app_pages.dart';
// import '../store/store.dart';
// import '../values/values.dart';
// import 'utils.dart';

// /*
//   * http 操作类
//   *
//   * 手册
//   * https://github.com/flutterchina/dio/blob/master/README-ZH.md
//   *
//   * 从 3 升级到 4
//   * https://github.com/flutterchina/dio/blob/master/migration_to_4.x.md
// */
// class HttpUtil {
//   factory HttpUtil() => _instance;
//   HttpUtil._internal() {
//     // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
//     final BaseOptions options = BaseOptions(
//       // 请求基地址,可以包含子路径
//       baseUrl: ConfigStore.to.apiBaseUrl,

//       // baseUrl: storage.read(key: STORAGE_KEY_APIURL) ?? SERVICE_API_BASEURL,
//       //连接服务器超时时间，单位是毫秒.
//       // connectTimeout: 10000,

//       // 响应流上前后两次接受到数据的间隔，单位为毫秒。
//       // receiveTimeout: 5000,

//       // Http请求头.
//       headers: <String, dynamic>{},

//       /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
//       /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
//       /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
//       /// 就会自动编码请求体.
//       contentType: 'application/json; charset=utf-8',
//     );

//     dio = Dio(options);

//     // // Cookie管理
//     // final CookieJar cookieJar = CookieJar();
//     // dio.interceptors.add(CookieManager(cookieJar));

//     // 添加sigen业务拦截器
//     dio.interceptors.add(SigenInterceptor());
//     // dio.interceptors.add(LogInterceptor(responseBody: false));
//   }
//   static final HttpUtil _instance = HttpUtil._internal();

//   late Dio dio;
//   CancelToken cancelToken = CancelToken();

//   /*
//    * 取消请求
//    *
//    * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
//    * 所以参数可选
//    */
//   void cancelRequests(CancelToken token) {
//     token.cancel('cancelled');
//   }

//   /// 读取本地配置
//   Map<String, dynamic>? getAuthorizationHeader() {
//     final Map<String, dynamic> headers = <String, dynamic>{};
//     if (Get.isRegistered<UserStore>() && UserStore.to.hasToken == true) {
//       headers['Authorization'] = 'Bearer ${UserStore.to.token}';
//     } else {
//       // 没有token，去登陆
//       Get.toNamed(Routes.LOGIN);
//     }
//     return headers;
//   }

//   /// restful get 操作
//   /// refresh 是否下拉刷新 默认 false
//   /// noCache 是否不缓存 默认 true
//   /// list 是否列表 默认 false
//   /// cacheKey 缓存key
//   /// cacheDisk 是否磁盘缓存
//   Future<dynamic> get(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     bool refresh = false,
//     bool noCache = !CACHE_ENABLE,
//     bool list = false,
//     String cacheKey = '',
//     bool cacheDisk = false,
//     bool isShowLoading = true,
//   }) async {
//     final Options requestOptions = options ?? Options();
//     requestOptions.extra ??= <String, dynamic>{};
//     requestOptions.extra!.addAll(<String, dynamic>{
//       'refresh': refresh,
//       'noCache': noCache,
//       'list': list,
//       'cacheKey': cacheKey,
//       'cacheDisk': cacheDisk,
//     });
//     requestOptions.headers = requestOptions.headers ?? <String, dynamic>{};
//     final Map<String, dynamic>? authorization = getAuthorizationHeader();
//     if (authorization != null) {
//       requestOptions.headers!.addAll(authorization);
//     }

//     if (isShowLoading) {
//       EasyLoading.show(dismissOnTap: true);
//     }
//     final Response<dynamic> response = await dio.get(
//       path,
//       queryParameters: queryParameters,
//       options: options,
//       cancelToken: cancelToken,
//     );
//     if (isShowLoading) {
//       EasyLoading.dismiss();
//     }
//     return response.data;
//   }

//   Future<dynamic> sigenGet(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     bool refresh = false,
//     bool noCache = !CACHE_ENABLE,
//     bool list = false,
//     String cacheKey = '',
//     bool cacheDisk = false,
//     bool isShowLoading = true,
//   }) async {
//     // final HttpMetric metric =
//     //     FirebasePerformance.instance.newHttpMetric(path, HttpMethod.Get);
//     // await metric.start();
//     final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
//     // 请求开始时间
//     final DateTime startTime = DateTime.now();
//     final Map<String, dynamic> response = await get(path,
//         queryParameters: queryParameters,
//         options: options,
//         refresh: refresh,
//         noCache: noCache,
//         list: list,
//         cacheKey: cacheKey,
//         cacheDisk: cacheDisk,
//         isShowLoading: isShowLoading) as Map<String, dynamic>;
//     // 请求结束时间
//     final DateTime endTime = DateTime.now();
//     // 请求耗时
//     final int duration = endTime.difference(startTime).inMilliseconds;
//     analytics.logEvent(name: 'sigen_http', parameters: <String, dynamic>{
//       'type': 'time_cost',
//       'method': 'get',
//       'path': path,
//       'duration': duration.toString(),
//     });
//     // await metric.stop();
//     return response['data'];
//   }

//   /// restful post 操作
//   Future<dynamic> post(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     bool isShowLoading = true,
//   }) async {
//     final Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? <String, dynamic>{};
//     final Map<String, dynamic>? authorization = getAuthorizationHeader();
//     if (authorization != null) {
//       requestOptions.headers!.addAll(authorization);
//     }
//     if (isShowLoading) {
//       EasyLoading.show(dismissOnTap: true);
//     }
//     final Response<dynamic> response = await dio.post(
//       path,
//       data: data,
//       queryParameters: queryParameters,
//       options: requestOptions,
//       cancelToken: cancelToken,
//     );
//     if (isShowLoading) {
//       EasyLoading.dismiss();
//     }
//     return response.data;
//   }

//   Future<dynamic> sigenPost(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     bool isShowLoading = true,
//   }) async {
//     // final HttpMetric metric =
//     //     FirebasePerformance.instance.newHttpMetric(path, HttpMethod.Post);
//     // await metric.start();
//     final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
//     // 请求开始时间
//     final DateTime startTime = DateTime.now();
//     final Map<String, dynamic> response = await post(
//       path,
//       data: data,
//       queryParameters: queryParameters,
//       options: options,
//       isShowLoading: isShowLoading,
//     ) as Map<String, dynamic>;
//     // 请求结束时间
//     final DateTime endTime = DateTime.now();
//     // 请求耗时
//     final int duration = endTime.difference(startTime).inMilliseconds;
//     analytics.logEvent(name: 'sigen_http', parameters: <String, dynamic>{
//       'type': 'time_cost',
//       'method': 'post',
//       'path': path,
//       'duration': duration.toString(),
//     });

//     // await metric.stop();
//     return response['data'];
//   }

//   /// restful put 操作
//   Future<dynamic> put(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     final Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? <String, dynamic>{};
//     final Map<String, dynamic>? authorization = getAuthorizationHeader();
//     if (authorization != null) {
//       requestOptions.headers!.addAll(authorization);
//     }
//     EasyLoading.show(dismissOnTap: true);
//     final Response<dynamic> response = await dio.put(
//       path,
//       data: data,
//       queryParameters: queryParameters,
//       options: requestOptions,
//       cancelToken: cancelToken,
//     );
//     EasyLoading.dismiss();
//     return response.data;
//   }

//   Future<dynamic> sigenPut(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     // final HttpMetric metric =
//     //     FirebasePerformance.instance.newHttpMetric(path, HttpMethod.Put);
//     // await metric.start();
//     final Map<String, dynamic> response = await put(path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options) as Map<String, dynamic>;
//     // await metric.stop();
//     return response['data'];
//   }

//   /// restful patch 操作
//   Future<dynamic> patch(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     final Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? <String, dynamic>{};
//     final Map<String, dynamic>? authorization = getAuthorizationHeader();
//     if (authorization != null) {
//       requestOptions.headers!.addAll(authorization);
//     }
//     EasyLoading.show(dismissOnTap: true);
//     final Response<dynamic> response = await dio.patch(
//       path,
//       data: data,
//       queryParameters: queryParameters,
//       options: requestOptions,
//       cancelToken: cancelToken,
//     );
//     EasyLoading.dismiss();
//     return response.data;
//   }

//   /// restful delete 操作
//   Future<dynamic> delete(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     final Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? <String, dynamic>{};
//     final Map<String, dynamic>? authorization = getAuthorizationHeader();
//     if (authorization != null) {
//       requestOptions.headers!.addAll(authorization);
//     }
//     EasyLoading.show(dismissOnTap: true);
//     final Response<dynamic> response = await dio.delete(
//       path,
//       data: data,
//       queryParameters: queryParameters,
//       options: requestOptions,
//       cancelToken: cancelToken,
//     );
//     EasyLoading.dismiss();
//     return response.data;
//   }

//   Future<dynamic> sigenDelete(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     // final HttpMetric metric =
//     //     FirebasePerformance.instance.newHttpMetric(path, HttpMethod.Put);
//     // await metric.start();
//     final Map<String, dynamic> response = await delete(path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options) as Map<String, dynamic>;
//     // await metric.stop();
//     return response['data'];
//   }

//   /// restful post form 表单提交操作
//   Future<dynamic> postForm(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     final Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? <String, dynamic>{};
//     final Map<String, dynamic>? authorization = getAuthorizationHeader();
//     if (authorization != null) {
//       requestOptions.headers!.addAll(authorization);
//     }
//     EasyLoading.show(dismissOnTap: true);
//     final Response<dynamic> response = await dio.post(
//       path,
//       data: FormData.fromMap(data as Map<String, dynamic>),
//       queryParameters: queryParameters,
//       options: requestOptions,
//       cancelToken: cancelToken,
//     );
//     EasyLoading.dismiss();
//     return response.data;
//   }

//   /// restful post Stream 流数据
//   Future<dynamic> postStream(
//     String path, {
//     required Iterable<dynamic> data,
//     int dataLength = 0,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     final Options requestOptions = options ?? Options();
//     requestOptions.headers = requestOptions.headers ?? <String, dynamic>{};
//     final Map<String, dynamic>? authorization = getAuthorizationHeader();
//     if (authorization != null) {
//       requestOptions.headers!.addAll(authorization);
//     }
//     requestOptions.headers!.addAll(<String, dynamic>{
//       Headers.contentLengthHeader: dataLength.toString(),
//     });
//     EasyLoading.show(dismissOnTap: true);
//     final Response<dynamic> response = await dio.post(
//       path,
//       data: Stream<dynamic>.fromIterable(
//           data.map((dynamic e) => <dynamic>[e]) as Iterable<List<int>>),
//       queryParameters: queryParameters,
//       options: requestOptions,
//       cancelToken: cancelToken,
//     );
//     EasyLoading.dismiss();
//     return response.data;
//   }
// }

// bool dataFormatCheck(Map<String, dynamic> data) {
//   if (data['code'] == null || data['msg'] == null || data['data'] == null) {
//     log('data format error, code or message not found: $data', name: 'HTTP');
//     return false;
//   } else {
//     return true;
//   }
// }

// // 异常处理
// class ErrorEntity implements Exception {
//   ErrorEntity({required this.code, required this.message});
//   int code = -1;
//   String message = '';

//   @override
//   String toString() {
//     if (message == '') {
//       return 'Exception';
//     }
//     return 'Exception: code $code, $message';
//   }
// }

// class SigenInterceptor extends InterceptorsWrapper {
//   static String languageType = 'zh_CN';

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     log('onRequest ${options.uri}  header: ${options.headers} ', name: 'HTTP');

// // http://nlb-k66ctjx69umlfl53mu.cn-shanghai.nlb.aliyuncs.com:9999/auth/oauth/token?grant_type=password"

//     if (options.path.contains('auth/oauth/token')) {
//       // 登录
//       // 头部添加
//       options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
//       options.headers['Authorization'] = 'Basic c2lnZW46c2lnZW4=';
//       options.headers['Accept-Language'] = 'zh-CN,zh;';
//     } else {
//       options.headers['Authorization'] = 'bearer ${UserStore.to.token}';
//       // options.headers['VERSION'] = 'wyc';
//       // options.headers['VERSION'] = 'LEVON';
//       // options.headers['VERSION'] = 'panhb03';
//       // options.headers['VERSION'] = 'lizhifang';
//       // options.headers['lang'] = 'en_US';
//       options.headers['lang'] = '${Get.locale}';
//     }
//     // //多语言
//     // options.headers['accept-language'] = languageType;

//     return handler.next(options);
//   }

//   @override
//   void onResponse(
//       Response<dynamic> response, ResponseInterceptorHandler handler) {
//     Logger.log(
//         'onResponse uri = ${response.realUri}\n data = ${json.encode(response.data)}',
//         tag: 'HTTP');

//     final Map<String, dynamic> data = response.data as Map<String, dynamic>;
//     if (false == dataFormatCheck(data)) {
//       EasyLoading.showError('data format error: $data');
//     }

//     data['code'] = data['code'] ?? -1;
//     data['data'] = data['data'] ?? <dynamic, dynamic>{};
//     // data['data'] = <dynamic, dynamic>{};

//     final int code = data['code'] as int;

//     // mock
//     // const int code = 1000001;

//     if (code == 0) {
//       // success response is code 0 and data is not null
//       handler.next(response); // continue
//     } else {
//       final bool solved = handleSigenErrorCode(code);

//       // 没有在框架中拦截的错误码，交给上层处理
//       if (solved != true) {
//         handler.reject(DioError(
//             requestOptions: response.requestOptions,
//             response: Response(
//               requestOptions: response.requestOptions,
//               statusCode: code,
//             )));
//       }

//       EasyLoading.dismiss();
//     }
//   }

//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     Logger.log('onError ${err.message} url: ${err.requestOptions.uri}',
//         tag: 'HTTP');
//     final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
//     analytics.logEvent(name: 'sigen_http', parameters: <String, dynamic>{
//       'type': 'http_error',
//       'msg': err.message,
//       'code': err.type.index,
//       'path': err.requestOptions.path,
//     });
//     EasyLoading.dismiss();

//     final ErrorEntity eInfo = createErrorEntity(err);
//     handleError(eInfo);

//     // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
//     // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
//     return handler.next(err); //continue
//   }

//   bool handleSigenErrorCode(int code) {
//     bool solved = true;
//     switch (code) {
//       case 1001:
//         EasyLoading.showError(LocaleKeys.errors_1001.tr);
//         break;
//       case 1002:
//         EasyLoading.showError(LocaleKeys.errors_1002.tr);
//         break;
//       case 1003:
//         EasyLoading.showError(LocaleKeys.errors_1003.tr);
//         break;
//       case 9999:
//         EasyLoading.showError(LocaleKeys.errors_9999.tr);
//         break;
//       case 11000:
//         EasyLoading.showError(LocaleKeys.errors_11000.tr);
//         break;
//       case 11001:
//         EasyLoading.showError(LocaleKeys.errors_11001.tr);
//         break;
//       case 11002:
//         EasyLoading.showError(LocaleKeys.errors_11002.tr);
//         break;
//       case 11003:
//         EasyLoading.showError(LocaleKeys.errors_11003.tr);
//         break;
//       case 11004:
//         EasyLoading.showError(LocaleKeys.errors_11004.tr);
//         // 跳转登录页
//         UserStore.to.onLogout();
//         Get.toNamed(Routes.LOGIN);
//         break;
//       case 12000:
//         EasyLoading.showError(LocaleKeys.errors_12000.tr);
//         break;
//       case 13005:
//         EasyLoading.showError(LocaleKeys.errors_13005.tr);
//         break;
//       case 13010:
//         EasyLoading.showError(LocaleKeys.errors_13010.tr);
//         break;
//       case 13101:
//         EasyLoading.showError(LocaleKeys.errors_13101.tr);
//         break;
//       case 13102:
//         EasyLoading.showError(LocaleKeys.errors_13102.tr);
//         break;
//       case 13106:
//         EasyLoading.showError(LocaleKeys.errors_13106.tr);
//         break;
//       case 15004:
//         EasyLoading.showError(LocaleKeys.errors_15004.tr);
//         break;
//       default:
//         // 没有在框架中拦截的错误码，交给上层处理
//         solved = false;
//         // EasyLoading.showError(LocaleKeys.errors_unknownBizError.tr);
//         break;
//     }
//     return solved;
//   }
// }

// /*
//    * error统一处理
//    */

// // 错误处理
// Future<void> handleError(ErrorEntity eInfo) async {
//   log('error.code -> ${eInfo.code}, error.message -> ${eInfo.message}');
//   switch (eInfo.code) {
//     case 401:
//       UserStore.to.onLogout();
//       EasyLoading.showError(eInfo.message);
//       break;
//     // token 失效
//     case 424:
//       // 使用refresh_token刷新token进行登录
//       final UserLoginResponseEntity? loginResponseEntity =
//           await UserAPI.refreshTokenLogin(
//               refreshToken: UserStore.to.refreshToken);
//       if (loginResponseEntity != null) {
//         // 刷新成功
//         UserStore.to.setToken(loginResponseEntity.accessToken ?? '');
//         UserStore.to.setRefreshToken(loginResponseEntity.refreshToken ?? '');
//       } else {
//         // 刷新失败
//         UserStore.to.onLogout();
//         Get.offNamed(Routes.LOGIN);
//         EasyLoading.showError(eInfo.message);
//       }
//       break;
//     case -1:
//       EasyLoading.showError(eInfo.message);
//       break;
//     default:
//       EasyLoading.showError(eInfo.message);
//       break;
//   }
// }

// // 错误信息
// ErrorEntity createErrorEntity(DioError error) {
//   switch (error.type) {
//     case DioErrorType.cancel:
//       return ErrorEntity(code: -1, message: LocaleKeys.errors_cancel.tr);
//     case DioErrorType.connectTimeout:
//       return ErrorEntity(
//           code: -1, message: LocaleKeys.errors_connectTimeout.tr);
//     case DioErrorType.sendTimeout:
//       return ErrorEntity(code: -1, message: LocaleKeys.errors_sendTimeout.tr);
//     case DioErrorType.receiveTimeout:
//       return ErrorEntity(
//           code: -1, message: LocaleKeys.errors_receiveTimeout.tr);
//     case DioErrorType.other:
//       return ErrorEntity(code: -1, message: error.message);
//     case DioErrorType.response:
//       {
//         try {
//           final int errCode =
//               error.response != null ? error.response!.statusCode! : -1;
//           switch (errCode) {
//             case 400:
//               return ErrorEntity(
//                   code: errCode, message: LocaleKeys.errors_400.tr);
//             case 401:
//               return ErrorEntity(
//                   code: errCode, message: LocaleKeys.errors_401.tr);
//             case 403:
//               return ErrorEntity(
//                   code: errCode, message: LocaleKeys.errors_403.tr);
//             case 404:
//               return ErrorEntity(
//                   code: errCode, message: LocaleKeys.errors_404.tr);
//             case 405:
//               return ErrorEntity(
//                   code: errCode, message: LocaleKeys.errors_405.tr);
//             case 424:
//               return ErrorEntity(
//                   code: errCode, message: LocaleKeys.errors_424.tr);
//             case 500:
//               return ErrorEntity(
//                   code: errCode, message: LocaleKeys.errors_500.tr);
//             case 502:
//               return ErrorEntity(
//                   code: errCode, message: LocaleKeys.errors_502.tr);
//             case 503:
//               return ErrorEntity(
//                   code: errCode, message: LocaleKeys.errors_503.tr);
//             case 505:
//               return ErrorEntity(
//                   code: errCode, message: LocaleKeys.errors_505.tr);
//             default:
//               {
//                 // return ErrorEntity(code: errCode, message: "未知错误");
//                 return ErrorEntity(
//                   code: errCode,
//                   message: error.response != null
//                       ? error.response!.statusMessage!
//                       : '',
//                 );
//               }
//           }
//         } on Exception catch (_) {
//           return ErrorEntity(
//               code: -1, message: LocaleKeys.errors_unknownError.tr);
//         }
//       }
//   }
// }





