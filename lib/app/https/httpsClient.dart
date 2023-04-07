import 'package:dio/dio.dart';

class HttpsClient {
  static String domain = 'https://api.wmdb.tv/api/v1/top';

  static Dio dio = Dio();

  HttpsClient() {
    dio.options.baseUrl = domain;
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 5);
  }

  Future get(apiUrl) async {
    try {
      var res = await dio.get(apiUrl);
      return res;
    } catch (e) {
      print('请求超时');
      return null;
    }
  }

  Future post(String apiUrl, {Map? data}) async {
    try {
      var res = await dio.post(apiUrl, data: data);
      return res;
    } catch (e) {
      print('请求超时');
      return null;
    }
  }
}
