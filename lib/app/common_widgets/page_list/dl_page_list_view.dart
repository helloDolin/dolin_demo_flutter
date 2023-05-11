import 'package:dolin_demo_flutter/app/common_widgets/status/app_empty.dart';
import 'package:dolin_demo_flutter/app/common_widgets/status/app_error.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../status/app_loading.dart';
import 'dl_base_controller.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext context, int index);

class DLPageListView extends StatelessWidget {
  final BasePageController pageController;
  final ItemWidgetBuilder itemBuilder;
  final ItemWidgetBuilder? separatorBuilder;
  final EdgeInsets? padding;
  final bool firstRefresh;
  final Function()? onLoginSuccess;
  final bool showPageLoadding;
  final bool loadMore;
  final Widget? header;

  const DLPageListView(
      {super.key,
      required this.pageController,
      required this.itemBuilder,
      this.separatorBuilder,
      this.padding,
      required this.firstRefresh,
      this.onLoginSuccess,
      required this.showPageLoadding,
      required this.loadMore,
      this.header});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            EasyRefresh(
              header: const MaterialHeader(),
              footer: loadMore
                  ? const MaterialFooter(
                      clamping: false, infiniteOffset: 70, triggerOffset: 70)
                  : null,
              controller: pageController.easyRefreshController,
              refreshOnStart: firstRefresh,
              onLoad: loadMore ? pageController.loadData : null,
              onRefresh: pageController.refreshData,
              child: ListView.separated(
                  padding: padding ?? EdgeInsets.zero,
                  controller: pageController.scrollController,
                  itemCount: header == null
                      ? pageController.list.length
                      : pageController.list.length + 1,
                  itemBuilder: header == null
                      ? itemBuilder
                      : (context, index) {
                          if (index == 0) {
                            return header;
                          }
                          return itemBuilder.call(context, index - 1);
                        },
                  separatorBuilder: header == null
                      ? (separatorBuilder ?? (context, i) => const SizedBox())
                      : (context, index) {
                          if (index == 0) {
                            return const SizedBox();
                          }
                          return separatorBuilder?.call(context, index - 1) ??
                              const SizedBox();
                        }),
            ),
            Offstage(
              offstage: !pageController.isPageEmpty.value,
              child: AppEmptyWidget(
                onRefresh: () => pageController.refreshData(),
              ),
            ),
            Offstage(
              offstage:
                  !(showPageLoadding && pageController.isPageLoadding.value),
              child: const AppLoaddingWidget(),
            ),
            Offstage(
              offstage: !pageController.isPageError.value,
              child: AppErrorWidget(
                errorMsg: pageController.errMsg.value,
                error: pageController.error,
                onRefresh: () => pageController.refreshData(),
              ),
            ),
          ],
        ));
  }
}
