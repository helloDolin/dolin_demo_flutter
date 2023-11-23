import 'package:dolin/app/data/comic/comic_tag_model.dart';
import 'package:dolin/app/data/comic/recommend_model.dart';
import 'package:dolin/app/https/https_client.dart';

/// 漫画 API
class ComicAPI {
  /// 分类
  static Future<List<ComicTagMoel>> category() async {
    final list = <ComicTagMoel>[];
    final res = await HttpsClient.instance.get(
      'https://nnv3api.idmzj.com/article/category.json',
      queryParameters: {},
    );
    for (final element in res as List<Map<String, dynamic>>) {
      list.add(ComicTagMoel.fromJson(element));
    }
    return list;
  }

  /// 推荐
  static Future<List<RecommendModel>> recommend() async {
    final list = <RecommendModel>[];
    final res = await HttpsClient.instance.get(
      'https://nnv3api.idmzj.com/novel/recommend.json',
      queryParameters: {},
    );
    for (final element in res as List) {
      list.add(RecommendModel.fromJson(element as Map<String, dynamic>));
    }
    return list;
  }
}
