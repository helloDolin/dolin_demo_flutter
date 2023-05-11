import 'package:dolin_demo_flutter/app/apis/comic/comic.dart';
import 'package:dolin_demo_flutter/app/common_widgets/page_list/dl_base_controller.dart';
import 'package:dolin_demo_flutter/app/data/comic/recommend_model.dart';

class ListController extends BasePageController<RecommendModel> {
  @override
  Future<List<RecommendModel>> getData(int page, int pageSize) async {
    var ls = await ComicAPI.recommend();
    return ls;
  }
}
