import 'package:dolin_demo_flutter/app/modules/home/views/fixTabBarView.dart';
import 'package:dolin_demo_flutter/app/modules/home/views/tab_list_view.dart';
import 'package:dolin_demo_flutter/app/util/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:underline_indicator/underline_indicator.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  Widget _tabBar() {
    return SizedBox(
      width: double.infinity,
      height: ScreenAdapter.height(25),
      child: TabBar(
          onTap: (value) {
            controller.pageController.jumpToPage(value);
            controller.tabIndexChanged(value);
          },
          controller: controller.tabController,
          isScrollable: true,
          labelColor: Colors.black,
          labelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
          ),
          indicator: UnderlineIndicator(
              strokeCap: StrokeCap.square,
              borderSide: BorderSide(
                  color: Colors.black, width: ScreenAdapter.height(3)),
              insets: EdgeInsets.only(
                  left: ScreenAdapter.width(10),
                  right: ScreenAdapter.width(10))),
          tabs: controller.categoryList
              .map((map) => Tab(
                    text: map['title'],
                  ))
              .toList()),
    );
  }

  Widget _content() {
    return Flexible(
        child: FixTabBarView(
      tabChange: (index) {
        controller.tabIndexChanged(index);
      },
      tabController: controller.tabController,
      pageController: controller.pageController,
      children: controller.categoryList.map((map) {
        return TabListView(
          source: map['source']!,
        );
      }).toList(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: Obx(() => AppBar(
              actions: [
                SizedBox(
                  width: 40,
                  child: IconButton(
                      onPressed: () {
                        Get.toNamed('/search',
                            arguments: {'searchPushCount': 1});
                      },
                      icon: const Icon(
                        Icons.search,
                      )),
                ),
                SizedBox(
                  width: 46,
                  child: TextButton(
                      onPressed: () async {
                        // Get.toNamed('/tabs/list', arguments: {'id': 123});
                        // Get.toNamed('/tabs/list?id=123');
                        final res = await Get.toNamed('/tabs/list/666');
                        print(res);
                      },
                      child: const Text('列表')),
                ),
                SizedBox(
                  width: 46,
                  child: TextButton(
                      onPressed: () {
                        Get.toNamed('/tabs/list/detail');
                      },
                      child: const Text('详情')),
                )
              ],
              title: Text(
                controller.pageTitle.value,
                style: const TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              // appbar 设置透明
              // backgroundColor:
              //     Colors.white.withOpacity(controller.opcity.value),
              elevation: 0,
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _tabBar(),
            _content(),
          ],
        ),
      ),
    );
  }
}
