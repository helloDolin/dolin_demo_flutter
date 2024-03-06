import 'package:dolin/app/constants/app_fonts.dart';
import 'package:dolin/app/modules/home/index/controllers/home_controller.dart';
import 'package:dolin/app/modules/home/movie_list/movie_list_view.dart';
import 'package:dolin/app/modules/mine/index/views/mine_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  StickyTabBarDelegate({required this.child});
  final TabBar child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: Colors.white,
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
            SliverAppBar(
              expandedHeight: 230,
              pinned: true,
              flexibleSpace: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.network(
                  'https://img1.baidu.com/it/u=1758123523,2376227049&fm=253&fmt=auto&app=138&f=JPEG?w=848&h=500',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
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
            return Expanded(
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
