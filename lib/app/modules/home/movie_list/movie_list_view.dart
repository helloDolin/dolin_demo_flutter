import 'package:dolin/app/common_widgets/gallery/index.dart';
import 'package:dolin/app/common_widgets/keepalive_wrapper.dart';
import 'package:dolin/app/constants/app_assets.dart';
import 'package:dolin/app/data/home/douban250.dart';
import 'package:dolin/app/modules/home/movie_list/movie_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MovieListView extends StatelessWidget {
  MovieListView({required this.source, super.key})
      : movieListController = MovieListController(
          source,
        ); // 相当于 tag 的方式（[GETX] Instance "MovieListController" with tag "Imdb" has been initialized）
  final MovieListController movieListController;
  final String source;

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: GetBuilder(
        init: movieListController,
        tag: source,
        builder: (controller) {
          return SmartRefresher(
            enablePullUp: true,
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => Container(
                height: 10,
                color: const Color.fromARGB(21, 102, 215, 164),
              ),
              itemBuilder: (c, i) {
                return Item(model: controller.data[i], index: i);
              },
              itemCount: controller.data.length,
            ),
          );
        },
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({required this.model, required this.index, super.key});
  final Douban250 model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openGallery<void>(context, 0, [model.shareImage]);
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('片名：${model.originalName ?? ''}'),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('排名：${index + 1}'),
            ),
          ],
        ),
      ),
    );
  }
}
