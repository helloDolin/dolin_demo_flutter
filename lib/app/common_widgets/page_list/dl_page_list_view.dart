import 'package:dolin/app/common_widgets/page_list/dl_base_controller.dart';
import 'package:dolin/app/common_widgets/status/app_empty.dart';
import 'package:dolin/app/common_widgets/status/app_error.dart';
import 'package:dolin/app/common_widgets/status/app_loading.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext context, int index);

class DLPageListView<T> extends StatelessWidget {
  const DLPageListView({
    required this.pageController,
    required this.itemBuilder,
    required this.firstRefresh,
    required this.showPageLoadding,
    required this.loadMore,
    super.key,
    this.separatorBuilder,
    this.padding,
    this.onLoginSuccess,
    this.header,
  });
  final BasePageController<T> pageController;
  final ItemWidgetBuilder itemBuilder;
  final ItemWidgetBuilder? separatorBuilder;
  final EdgeInsets? padding;
  final bool firstRefresh;
  final void Function()? onLoginSuccess;
  final bool showPageLoadding;
  final bool loadMore;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          EasyRefresh(
            header: const MaterialHeader(),
            footer: loadMore
                ? const MaterialFooter(
                    clamping: false,
                    infiniteOffset: 70,
                    triggerOffset: 70,
                  )
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
                    },
            ),
          ),
          Offstage(
            offstage: !pageController.isPageEmpty.value,
            child: AppEmptyWidget(
              onRefresh: pageController.refreshData,
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
              onRefresh: pageController.refreshData,
            ),
          ),
        ],
      ),
    );
  }
}
