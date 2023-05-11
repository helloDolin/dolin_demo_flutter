import 'package:flutter/material.dart';

class TabAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Tab> tabs;
  final TabController? controller;
  final Widget? action;
  const TabAppBar({required this.tabs, this.controller, this.action, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // color: Colors.red,
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: TabBar(
                isScrollable: true,
                controller: controller,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
                tabs: tabs,
              ),
            ),
            action ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
