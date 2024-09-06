import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 列表页公共逻辑
mixin ListPageCommonLogic<T> on GetxController {
  late RefreshController refreshController = RefreshController();
  List<T> listData = [];
  final int pageSize = 10;
  int curPage = 1;
  bool canLoad = true;
  bool requested = false;
  bool get showEmpty => requested && listData.isEmpty;

  void onRefresh() {
    reqData(isRefresh: true).then((_) {
      refreshController
        ..refreshCompleted()
        ..resetNoData();
    }).catchError((_) {
      refreshController
        ..refreshFailed()
        ..resetNoData();
      update();
    });
  }

  void onLoading() {
    if (canLoad) {
      reqData().then((_) {
        refreshController.loadComplete();
      }).catchError((_) {
        refreshController.loadFailed();
        if (curPage > 1) {
          curPage--;
        }
      });
    } else {
      refreshController.loadNoData();
    }
  }

  Future<void> reqData({bool isRefresh = false}) async {
    requested = true;
    if (isRefresh) {
      curPage = 1;
      listData.clear();
    } else {
      curPage++;
    }

    final List<T> res = await reqListData();
    listData.addAll(res);
    canLoad = res.length == pageSize;
    if (!canLoad && !isRefresh) {
      refreshController.loadNoData();
    }
    update();
  }

  /// 交由混入类实现
  Future<List<T>> reqListData();

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
