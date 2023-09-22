import 'package:dolin/app/common_widgets/keepalive_wrapper.dart';
import 'package:dolin/app/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common_widgets/gallery/index.dart';
import '../../../constants/app_assets.dart';
import '../../../data/home/douban250.dart';
import 'movie_list_controller.dart';

class MovieListView extends StatelessWidget {
  final MovieListController movieListController;
  final String source;
  MovieListView({Key? key, required this.source})
      : movieListController = MovieListController(source),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: GetBuilder(
        init: movieListController,
        tag: source,
        builder: (controller) {
          return Stack(children: [
            SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: controller.refreshController,
              onRefresh: controller.onRefresh,
              onLoading: controller.onLoading,
              child: ListView.separated(
                controller: controller.scrollController,
                separatorBuilder: (context, index) => Container(
                  height: 10,
                  color: const Color.fromARGB(21, 102, 215, 164),
                ),
                itemBuilder: (c, i) {
                  return Item(model: controller.data[i], index: i);
                },
                itemCount: controller.data.length,
              ),
            ),
            Obx(() => Positioned(
                bottom: 20,
                right: 20,
                child: controller.isShowUpIcon.value
                    ? IconButton(
                        onPressed: () {
                          controller.scrollController.animateTo(-20,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.bounceInOut);
                        },
                        icon: const Icon(
                          AppFonts.back2Top,
                          size: 50,
                        ),
                      )
                    : const SizedBox.shrink())),
          ]);
        },
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({super.key, required this.model, required this.index});
  final Douban250 model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openGallery(context, 0, [model.shareImage]);
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenWidth * 880 / 540, // 图片尺寸：540 * 880
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FadeInImage.assetNetwork(
                    placeholder: AppAssets.placeholderPng,
                    placeholderFit: BoxFit.cover,
                    image: model.shareImage,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        const SizedBox(
                      child: Text('图片加载失败'),
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Text('片名：${model.originalName ?? ''}')),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Text('排名：${index + 1}')),
          ],
        ),
      ),
    );
  }
}
