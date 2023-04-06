import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef TabChange = Function(int index);

class FixTabBarView extends StatelessWidget {
  const FixTabBarView({
    required this.children,
    required this.tabController,
    required this.pageController,
    required this.tabChange,
    Key? key,
    this.physics = const ScrollPhysics(),
    this.dragStartBehavior = DragStartBehavior.start,
  }) : super(key: key);

  final TabController tabController;
  final PageController pageController;
  final List<Widget> children;
  final ScrollPhysics physics;
  final DragStartBehavior dragStartBehavior;
  final TabChange tabChange;

  @override
  Widget build(BuildContext context) {
    return PageView(
      dragStartBehavior: dragStartBehavior,
      physics: physics,
      controller: pageController,
      children: children,
      onPageChanged: (index) {
        tabController.animateTo(index);
        tabChange(index);
      },
    );
  }
}
