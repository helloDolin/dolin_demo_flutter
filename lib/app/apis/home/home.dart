import 'package:dolin/app/data/home/douban250.dart';
import 'package:dolin/app/https/httpsClient.dart';

class HomeAPI {
  static Future<List<Douban250>> movieList(
      String source, int pageSize, int skip,
      {bool isRefresh = false}) async {
    final res = await HttpsClient.instance
        .get('https://api.wmdb.tv/api/v1/top', queryParameters: {
      'type': source,
      'skip': skip,
      'limit': pageSize,
      'lang': 'Cn',
    });
    return douban250FromList(res);
  }
}
