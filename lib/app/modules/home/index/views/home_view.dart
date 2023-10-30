import 'package:dolin/app/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../mine/index/views/mine_view.dart';
import '../../movie_list/movie_list_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: 从左边抽出
      // endDrawer: 从右边抽出
      endDrawer: const Drawer(
        child: MineView(),
      ),
      // appbar 只接收 PreferredSize 类型
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: Obx(() => AppBar(
              actions: [
                Builder(builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(AppFonts.mine),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  );
                }),
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
          const SizedBox(height: 10),
          Expanded(child: _content()),
        ],
      )),
    );
  }

  Widget _tabBar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 25.h,
      child: TabBar(
          controller: controller.tabController,
          isScrollable: false,
          tabs: controller.categoryList
              .map((map) => Tab(
                    text: map['title'],
                  ))
              .toList()),
    );
  }

  Widget _content() {
    return TabBarView(
        controller: controller.tabController,
        children: controller.categoryList.map((map) {
          return MovieListView(
            source: map['source']!,
          );
        }).toList());
  }
}
