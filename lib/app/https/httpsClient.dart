import 'package:dio/dio.dart';

class HttpsClient {
  /// 单例
  static final HttpsClient _instance = HttpsClient._internal();
  static HttpsClient get instance => _instance;

  /// 工厂构造函数
  factory HttpsClient() {
    return _instance;
  }

  /// 构造函数私有化，防止被误创建
  HttpsClient._internal() {
    var options = BaseOptions(
      baseUrl: 'https://api.wmdb.tv/api/v1/top',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );
    dio = Dio(options);
  }

  late Dio dio;

  Future get(apiUrl) async {
    try {
      print('''
=============apiUrl=================
$apiUrl
''');
      var res = await dio.get(apiUrl);
      return res;
    } catch (e) {
      print('请求超时');
      return null;
    }
  }

  Future post(String apiUrl, {Map? data}) async {
    try {
      print('''
=============apiUrl=================
$apiUrl
''');
      var res = await dio.post(apiUrl, data: data);
      return res;
    } catch (e) {
      print('请求超时');
      return null;
    }
  }
}
