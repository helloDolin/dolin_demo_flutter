import 'package:dolin/app/common_widgets/keepalive_wrapper.dart';
import 'package:dolin/app/common_widgets/page_list/dl_page_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';

import '../../../data/comic/recommend_model.dart';
import '../novel_detail/views/novel_detail_view.dart';
import 'list_controller.dart';

class ListView extends StatelessWidget {
  final ListController controller;

  ListView({Key? key})
      : controller = Get.put(ListController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: DLPageListView(
        padding: const EdgeInsets.all(12),
        pageController: controller,
        firstRefresh: true,
        loadMore: false,
        showPageLoadding: true,
        itemBuilder: (context, index) {
          final RecommendModel item = controller.list[index];
          if (item.categoryId == 57) {
            return _buildBanner(item);
          }
          return _buildCard(item);
          // return Text(item.title ?? '');
        },
      ),
    );
  }

  Container _buildCard(RecommendModel item) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Text(item.title.toString())),
              SizedBox(
                height: 48,
                child: buildShowMore(onTap: () {}),
              )
            ],
          ),
          MasonryGridView.count(
            crossAxisCount: 3,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            itemCount: item.data!.length,
            itemBuilder: (context, index) {
              final RecommendItemModel obj = item.data![index];
              return InkWell(
                onTap: () {
                  Get.to(() => NovelDetailView(
                        id: obj.id ?? -1,
                        title: obj.title ?? '详情',
                      ));
                },
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      child: AspectRatio(
                        aspectRatio: 27 / 36,
                        child: Image.network(
                          obj.cover ?? '',
                          width: 270,
                          height: 360,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      obj.title ?? '',
                      maxLines: 1,
                      style: const TextStyle(height: 1.2),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      obj.subTitle ?? obj.status ?? '',
                      maxLines: 1,
                      style: const TextStyle(
                        height: 1.2,
                        fontSize: 12,
                        color: Colors.grey,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildShowMore({required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: const [
          Text(
            "查看更多",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Icon(Icons.chevron_right, size: 18, color: Colors.grey),
        ],
      ),
    );
  }

  ClipRRect _buildBanner(RecommendModel item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: AspectRatio(
        aspectRatio: 75 / 40,
        child: Swiper(
          autoplay: true,
          // autoplayDelay: 1000,
          itemCount: item.data!.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Image.network(item.data![index].cover ?? ''),
                Positioned(
                  bottom: 4,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      item.data![index].title ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 6.0,
                            color: Colors.black45,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          onTap: (i) {
            // controller.openDetail(item.data[i]);
          },
          pagination: SwiperCustomPagination(
              builder: (context, config) => Align(
                    alignment: const Alignment(1, 1),
                    child: Container(
                      margin: const EdgeInsets.only(right: 0, bottom: 8),
                      height: 30,
                      width: 40,
                      alignment: const Alignment(0.3, 0),
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                      child: Text(
                        '${config.activeIndex + 1}/${config.itemCount}',
                        style:
                            const TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
