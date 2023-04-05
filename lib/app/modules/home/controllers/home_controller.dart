import 'package:dolin_demo_flutter/app/data/douban250.dart';
import 'package:dolin_demo_flutter/app/service/httpsClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RxBool flag = false.obs;
  RxDouble opcity = 1.0.obs;
  RxList<Douban250> doubanList = <Douban250>[].obs;
  int pageIndex = 0;
  final pageSize = 5;
  RxString pageTitle = 'IMDB250'.obs;
  String source = 'Imdb';

  String getSwitchTitle() {
    if (pageTitle.value == '豆瓣250') {
      return '切换至IMDB250';
    } else {
      return '切换至豆瓣250';
    }
  }

  void switch2DoubanOrImdb() {
    if (pageTitle.value == '豆瓣250') {
      pageTitle.value = 'IMDB250';
      source = 'Imdb';
    } else {
      pageTitle.value = '豆瓣250';
      source = 'Douban';
    }
    onRefresh();
  }

  void onRefresh() async {
    pageIndex = 0;
    doubanList.value = [];
    await reqDouban250Refersh();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    pageIndex += 1;
    await reqDouban250More();
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    reqDouban250Refersh();
    scrollController.addListener(() {
      print(
          'scrollController.position.pixels:${scrollController.position.pixels}');
      if (scrollController.position.pixels <= 100) {
        double num = scrollController.position.pixels / 100;
        // if (num <= 0.0) {
        //   num = 0.0;
        // } else if (num >= 0.8) {
        //   num = 1;
        // }
        opcity.value = num;
      }
      if (scrollController.position.pixels > 10 &&
          scrollController.position.pixels < 20) {
        if (flag.value == false) {
          flag.value = true;
        }
      }
      if (scrollController.position.pixels < 10) {
        if (flag.value == true) {
          flag.value = false;
        }
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    print('HomeController onReady');
    super.onReady();
  }

  @override
  void onClose() {
    print('HomeController onReady');
    super.onClose();
  }

  reqDouban250Refersh() async {
    String apiUrl =
        'https://api.wmdb.tv/api/v1/top?type=$source&skip=$pageIndex&limit=$pageSize&lang=Cn';
    print(apiUrl);
    final res = await HttpsClient().get(apiUrl);
    if (res != null) {
      List<Douban250> douban250List = douban250FromList(res.data);
      doubanList.value = douban250List;
      update();
    }
  }

  reqDouban250More() async {
    String apiUrl =
        'https://api.wmdb.tv/api/v1/top?type=Imdb&skip=$pageIndex&limit=$pageSize&lang=Cn';
    print(apiUrl);
    final res = await HttpsClient().get(apiUrl);
    if (res != null) {
      List<Douban250> douban250List = douban250FromList(res.data);
      doubanList.addAll(douban250List);
      update();
      print(doubanList.length);
    }
  }
}
