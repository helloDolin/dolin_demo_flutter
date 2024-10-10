import 'package:cached_network_image/cached_network_image.dart';
import 'package:dolin/app/common_widgets/gallery/index.dart';
import 'package:dolin/app/data/home/douban250.dart';
import 'package:dolin/app/modules/home/movie_list/movie_list_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MovieListView extends StatelessWidget {
  MovieListView({required this.source, super.key})
      : movieListController = MovieListController(
          source,
        );
  final MovieListController movieListController;
  final String source;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: movieListController,
      // [GETX] Instance "MovieListController" has been created with tag "Douban"
// [GETX] Instance "MovieListController" has been created with tag "Imdb"
      tag: source,
      builder: (controller) {
        return SmartRefresher(
          enablePullUp: true,
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          onLoading: controller.onLoading,
          child: CustomScrollView(
            // 这个设置，很重要，要不然 tabview 会一起滚动，😅
            key: PageStorageKey<String>(source), // 保持滑动位置,
            slivers: [
              // 占位
              Builder(
                builder: (ctx) {
                  return SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      ctx,
                    ),
                  );
                },
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Item(
                      model: controller.data[index],
                      index: index,
                    );
                  },
                  childCount: controller.data.length,
                ),
              ),
            ],
          ),

          // ListView.separated(
          //   padding: EdgeInsets.zero,
          //   separatorBuilder: (context, index) => Container(
          //     height: 10,
          //     color: const Color.fromARGB(21, 102, 215, 164),
          //   ),
          //   itemBuilder: (c, i) {
          //     return Item(model: controller.data[i], index: i);
          //   },
          //   itemCount: controller.data.length,
          // ),
        );
      },
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
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: model.shareImage,
                  placeholder: (context, url) =>
                      const CupertinoActivityIndicator(),
                  errorWidget: (context, error, stackTrace) => const SizedBox(
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
