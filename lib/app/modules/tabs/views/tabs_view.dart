import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: PageView(
            controller: controller.pageController,
            // onPageChanged: ((value) => controller.setCurrentIndex(value)),
            physics: const NeverScrollableScrollPhysics(), // 禁止左右滑动
            children: controller.pages),
        bottomNavigationBar: Theme(
          // 去掉item水波纹效果
          data: ThemeData(
            // brightness: Brightness.light,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 22,
            backgroundColor: Colors.white,
            fixedColor: Colors.red,
            currentIndex: controller.currentIndex.value,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            type: BottomNavigationBarType.fixed, // 如果底部有4个或者4个以上的菜单的时候就需要配置这个参数
            onTap: (index) {
              controller.setCurrentIndex(index);
              controller.pageController.jumpToPage(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home), label: LocaleKeys.tabs_home.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.category),
                  label: LocaleKeys.tabs_category.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.room_service),
                  label: LocaleKeys.tabs_service.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.shopping_cart),
                  label: LocaleKeys.tabs_cart.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.people),
                  label: LocaleKeys.tabs_mine.tr),
            ],
          ),
        ),
        floatingActionButton: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class MyFloatingActionButtonLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(
        (scaffoldGeometry.scaffoldSize.width -
                scaffoldGeometry.floatingActionButtonSize.width) /
            2.0,
        (scaffoldGeometry.scaffoldSize.width -
                scaffoldGeometry.floatingActionButtonSize.width) /
            2.0);
  }
}
