import 'package:dolin_demo_flutter/app/common_widgets/dl_tabbar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:underline_indicator/underline_indicator.dart';

import '../../../../routes/app_pages.dart';
import '../../movie_list/movie_list_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar 只接收 PreferredSize 类型
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: Obx(() => AppBar(
              actions: [
                SizedBox(
                  // width: 46,
                  child: TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.DETAIL, arguments: 1);
                      },
                      child: const Text(
                        'GetX 进入相同页面',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )),
                )
              ],
              title: Text(
                controller.pageTitle.value,
              ),
              centerTitle: true,
              // backgroundColor:
              //     Colors.white.withOpacity(controller.opcity.value), // appbar 设置透明
              elevation: 0, // 取消 app bar 下面的横线
            )),
      ),
      body: SafeArea(
          child: Column(
        children: [
          _tabBar(context),
          const SizedBox(
            height: 10,
          ),
          _content(),
        ],
      )),
    );
  }

  Widget _tabBar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 25.h,
      child: TabBar(
          onTap: (value) {
            controller.pageController.jumpToPage(value);
            controller.tabIndexChanged(value);
          },
          controller: controller.tabController,
          isScrollable: true,
          indicator: UnderlineIndicator(
              strokeCap: StrokeCap.square,
              borderSide: BorderSide(
                color: Theme.of(context).tabBarTheme.indicatorColor!,
                width: 3.h,
              ),
              insets: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
              )),
          tabs: controller.categoryList
              .map((map) => Tab(
                    text: map['title'],
                  ))
              .toList()),
    );
  }

  Widget _content() {
    return Flexible(
        child: DLTabBarView(
      tabChange: (index) {
        controller.tabIndexChanged(index);
      },
      tabController: controller.tabController,
      pageController: controller.pageController,
      children: controller.categoryList.map((map) {
        return MovieListView(
          source: map['source']!,
        );
      }).toList(),
    ));
  }
}
