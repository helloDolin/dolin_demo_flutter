import 'package:dolin/app/common_widgets/dl_tab_appbar.dart';
import 'package:dolin/app/common_widgets/status/app_error.dart';
import 'package:dolin/app/common_widgets/status/app_loading.dart';
import 'package:dolin/app/constants/app_fonts.dart';
import 'package:dolin/app/modules/comic/index/controllers/comic_controller.dart';
import 'package:dolin/app/modules/comic/recommend_list/list_view.dart'
    as recommend_list;
import 'package:dolin/app/util/random_color_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComicView extends GetView<ComicController> {
  const ComicView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComicController>(
      init: controller,
      builder: (controller) {
        if (controller.loading) {
          return const Scaffold(
            body: AppLoaddingWidget(),
          );
        }
        if (!controller.loading && controller.error) {
          return Scaffold(
            body: AppErrorWidget(
              errorMsg: controller.errMsg,
              onRefresh: controller.reqCategores,
            ),
          );
        }
        return Scaffold(
          appBar: TabAppBar(
            controller: controller.tabController,
            // tabs: controller.categores
            //     .map((e) => Tab(
            //           text: e.tagName,
            //         ))
            //     .toList(),
            tabs: const [
              Tab(text: '推荐'),
              Tab(text: '更新'),
              Tab(text: '分类'),
              Tab(text: '排行'),
            ],
            action: IconButton(
              onPressed: null,
              icon: Icon(
                AppFonts.comic,
                color: getRandomColor(),
              ),
            ),
          ),
          body: TabBarView(
            controller: controller.tabController,
            // children:
            // controller.categores.map((e) => Text(e.tagName ?? '')).toList(),
            children: [
              recommend_list.ListView(),
              const Text('更新'),
              const Text('分类'),
              const Text('排行'),
            ],
          ),
        );
      },
    );
  }
}
