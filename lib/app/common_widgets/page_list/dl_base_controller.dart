import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  RxBool isPageLoadding = false.obs;
  var isLoadding = false;
  RxBool isPageEmpty = false.obs;
  RxBool isPageError = false.obs;
  RxBool isNotLogin = false.obs;
  RxString errMsg = ''.obs;

  Error? error;

  void handleError(Object exceptiron, {bool showPageError = false}) {
    final msg = exceptiron.toString();
    if (exceptiron is Error) {
      error = exceptiron;
    }
    if (showPageError) {
      isPageError.value = true;
      errMsg.value = msg;
    } else {
      SmartDialog.showToast(msg);
    }
  }

  void onLogin() {}
  void onLogout() {}
}

class BasePageController<T> extends BaseController {
  final ScrollController scrollController = ScrollController();
  final EasyRefreshController easyRefreshController = EasyRefreshController();

  int curPage = 1;
  int count = 0;
  int maxPage = 0;
  int pageSize = 10;

  RxBool canLoadMore = false.obs;
  RxList list = <T>[].obs;

  Future loadData() async {
    try {
      if (isLoadding) {
        return;
      }
      isLoadding = true;
      isPageError.value = false;
      isPageEmpty.value = false;
      isNotLogin.value = false;
      error = null;
      isPageLoadding.value = curPage == 1;

      final res = await getData(curPage, pageSize);
      if (res.isNotEmpty) {
        curPage++;
        canLoadMore.value = true;
        isPageEmpty.value = false;
      } else {
        canLoadMore.value = false;
        if (curPage == 1) {
          isPageEmpty.value = true;
        }
      }

      if (curPage == 1) {
        list.value = res;
      } else {
        list.addAll(res);
      }
    } catch (e) {
      handleError(e, showPageError: curPage == 1);
    } finally {
      isLoadding = false;
      isPageLoadding.value = false;
    }
  }

  Future<List<T>> getData(int page, int pageSize) async {
    return [];
  }

  Future refreshData() async {
    curPage = 1;
    list.clear();
    await loadData();
  }

  void scrollToTopOrRefresh() {
    if (scrollController.offset > 0) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    } else {
      easyRefreshController.callRefresh();
    }
  }
}
