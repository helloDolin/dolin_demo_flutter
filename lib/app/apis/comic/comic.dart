import 'package:dolin_demo_flutter/app/data/comic/recommend_model.dart';
import 'package:dolin_demo_flutter/app/https/httpsClient.dart';

import '../../data/comic/comic_tag_model.dart';

class ComicAPI {
  static Future<List<ComicTagMoel>> category() async {
    final list = <ComicTagMoel>[];
    final res = await HttpsClient.instance.get(
        'https://nnv3api.idmzj.com/article/category.json',
        queryParameters: {});
    for (var element in res) {
      list.add(ComicTagMoel.fromJson(element));
    }
    return list;
  }

  static Future<List<RecommendModel>> recommend() async {
    final list = <RecommendModel>[];
    final res = await HttpsClient.instance.get(
        'https://nnv3api.idmzj.com/novel/recommend.json',
        queryParameters: {});
    for (var element in res) {
      list.add(RecommendModel.fromJson(element));
    }
    return list;
  }
}
