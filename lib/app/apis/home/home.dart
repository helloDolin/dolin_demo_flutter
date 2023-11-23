import 'package:dolin/app/data/home/douban250.dart';
import 'package:dolin/app/https/https_client.dart';

/// 首页 API
class HomeAPI {
  /// 电影列表
  static Future<List<Douban250>> movieList(
    String source,
    int pageSize,
    int skip, {
    bool isRefresh = false,
  }) async {
    final res = await HttpsClient.instance.get(
      'https://api.wmdb.tv/api/v1/top',
      queryParameters: {
        'type': source,
        'skip': skip,
        'limit': pageSize,
        'lang': 'Cn',
      },
    );
    final result = <Douban250>[];
    for (final element in res as List<dynamic>) {
      result.add(
        Douban250.fromJson(element as Map<String, dynamic>),
      );
    }

    return result;
  }
}
