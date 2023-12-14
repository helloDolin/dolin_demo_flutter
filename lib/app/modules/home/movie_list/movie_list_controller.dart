import 'package:dolin/app/apis/home/home.dart';
import 'package:dolin/app/data/home/douban250.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const pageSize = 5;

class MovieListController extends GetxController {
  MovieListController(this.source);
  final String source;

  late RefreshController refreshController;
  late ScrollController scrollController;

  RxBool isShowUpIcon = false.obs;
  RxList<Douban250> data = <Douban250>[].obs;

  int skip = 0;
  final int pageSize = 10;
  int curPage = 1;
  bool canLoad = true;

  void onRefresh() {
    reqData(isRefresh: true).then((_) {
      refreshController
        ..refreshCompleted()
        ..resetNoData();
    }).catchError((_) {
      refreshController
        ..refreshFailed()
        ..resetNoData();
    });
  }

  void onLoading() {
    // data.length % pageSize == 0
    if (canLoad) {
      reqData().then((_) {
        refreshController.loadComplete();
      }).catchError((_) {
        refreshController.loadFailed();
      });
    } else {
      refreshController.loadNoData();
    }
  }

  Future<void> reqData({bool isRefresh = false}) async {
    if (isRefresh) {
      skip = 0;
      curPage = 1;

      data.clear();
    } else {
      skip += pageSize;
      curPage++;
    }

    final res = await HomeAPI.movieList(source, pageSize, skip);
    data.addAll(res);
    canLoad = res.length == pageSize;
    if (!canLoad && !isRefresh) {
      refreshController.loadNoData();
    }
    update();
  }

  @override
  void onInit() {
    refreshController = RefreshController();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels > 200 &&
          isShowUpIcon.value == false) {
        isShowUpIcon.value = true;
      }
      if (scrollController.position.pixels < 200 &&
          isShowUpIcon.value == true) {
        isShowUpIcon.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    refreshController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    refreshController.requestRefresh();
    super.onReady();
  }
}
