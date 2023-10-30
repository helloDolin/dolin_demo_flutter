import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../apis/home/home.dart';
import '../../../data/home/douban250.dart';

const pageSize = 5;

class MovieListController extends GetxController {
  final String source;
  MovieListController(this.source);

  late RefreshController refreshController;
  late ScrollController scrollController;

  RxBool isShowUpIcon = false.obs;
  RxList<Douban250> data = <Douban250>[].obs;

  int skip = 0;

  void onRefresh() {
    reqData(isRefresh: true).then((_) {
      refreshController.refreshCompleted();
      refreshController.resetNoData();
    }).catchError((_) {
      refreshController.refreshFailed();
    });
  }

  void onLoading() {
    if (data.length % pageSize == 0) {
      reqData(isRefresh: false).then((_) {
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
      data.clear();
    } else {
      skip += pageSize;
    }

    final res = await HomeAPI.movieList(source, pageSize, skip);
    data.addAll(res);
    update();
  }

  @override
  void onInit() {
    refreshController = RefreshController(initialRefresh: false);
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
