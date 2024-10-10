import 'dart:ui';

import 'package:dolin/app/common_widgets/keepalive_wrapper.dart';
import 'package:dolin/app/constants/app_fonts.dart';
import 'package:dolin/app/modules/home/index/controllers/home_controller.dart';
import 'package:dolin/app/modules/home/movie_list/movie_list_view.dart';
import 'package:dolin/app/modules/mine/index/views/mine_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  StickyTabBarDelegate({required this.child, this.bgColor = Colors.white});
  final TabBar child;
  final Color bgColor;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: bgColor,
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            // 占位，保证切换 tab 时，不受其他滑动的影响
            SliverOverlapAbsorber(
              sliver: SliverAppBar(
                // ignore: avoid_redundant_argument_values
                forceElevated: false, // 为 true 时会有底部阴影
                expandedHeight: 190,
                pinned: true,
                flexibleSpace: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 2,
                    sigmaY: 2,
                  ),
                  child: SizedBox.expand(
                    child: Image.asset(
                      'assets/images/btc_2_the_moon.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                bgColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
                child: TabBar(
                  controller: controller.tabController,
                  tabs: controller.categoryList
                      .map(
                        (map) => Tab(
                          text: map['title'],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: controller.tabController,
          children: controller.categoryList.map((map) {
            return KeepAliveWrapper(
              child: MovieListView(
                source: map['source']!,
              ),
            );
          }).toList(),
        ),
      ),
    );

    return Scaffold(
      // drawer: 从左边抽出
      // endDrawer: 从右边抽出
      endDrawer: const Drawer(
        child: MineView(),
      ),
      // appbar 只接收 PreferredSize 类型
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: Obx(
          () => AppBar(
            actions: [
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(AppFonts.mine),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  );
                },
              ),
            ],
            title: Text(
              controller.pageTitle.value,
            ),
            centerTitle: true,
            // backgroundColor:
            //     Colors.white.withOpacity(controller.opcity.value), // appbar 设置透明
            elevation: 0, // 取消 app bar 下面的横线
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _tabBar(context),
            const SizedBox(height: 10),
            Expanded(child: _content()),
          ],
        ),
      ),
    );
  }

  Widget _tabBar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 25.h,
      child: TabBar(
        controller: controller.tabController,
        tabs: controller.categoryList
            .map(
              (map) => Tab(
                text: map['title'],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _content() {
    return TabBarView(
      controller: controller.tabController,
      children: controller.categoryList.map((map) {
        return MovieListView(
          source: map['source']!,
        );
      }).toList(),
    );
  }
}
