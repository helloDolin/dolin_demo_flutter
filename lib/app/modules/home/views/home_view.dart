import 'package:dolin_demo_flutter/app/data/douban250.dart';
import 'package:dolin_demo_flutter/app/service/keepAliveWrapper.dart';
import 'package:dolin_demo_flutter/app/util/randomColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        keepAlive: true,
        child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: Obx(() => AppBar(
                  actions: [
                    TextButton(
                      onPressed: () {
                        controller.switch2DoubanOrImdb();
                      },
                      child: Text(controller.getSwitchTitle()),
                    ),
                  ],
                  title: Text(
                    controller.pageTitle.value,
                    style: const TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                  // appbar 设置透明
                  backgroundColor:
                      Colors.white.withOpacity(controller.opcity.value),
                  elevation: 0,
                )),
          ),
          body: Obx(() => controller.doubanList.isNotEmpty
              ? SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: const WaterDropHeader(),
                  footer: CustomFooter(
                    builder: (context, mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = const Text("上拉加载");
                      } else if (mode == LoadStatus.loading) {
                        body = const CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = const Text("加载失败！点击重试！");
                      } else if (mode == LoadStatus.canLoading) {
                        body = const Text("松手,加载更多!");
                      } else {
                        body = const Text("没有更多数据了!");
                      }
                      return SizedBox(
                        height: 55.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  controller: controller.refreshController,
                  onRefresh: controller.onRefresh,
                  onLoading: controller.onLoading,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Container(
                      height: 10,
                      color: getRandomColor().withOpacity(0.3),
                    ),
                    itemBuilder: (c, i) {
                      return Item(model: controller.doubanList[i], index: i);
                    },
                    itemCount: controller.doubanList.length,
                  ),
                )
              : const Center(child: CircularProgressIndicator())),
        ));
  }
}

class Item extends StatelessWidget {
  const Item({super.key, required this.model, required this.index});
  final Douban250 model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: model.shareImage,
                  fit: BoxFit.fitWidth,
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
    );
  }
}
