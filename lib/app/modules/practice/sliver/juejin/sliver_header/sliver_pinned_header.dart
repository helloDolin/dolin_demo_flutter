import 'package:flutter/material.dart';

class SliverPinnedHeader extends StatelessWidget {
  const SliverPinnedHeader({
    required this.child,
    super.key,
    this.color = Colors.white,
  });
  final PreferredSizeWidget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverPinnedHeaderDelegate(
        child: child,
        color: color,
      ),
    );
  }
}

class _SliverPinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverPinnedHeaderDelegate({required this.child, required this.color});
  final PreferredSizeWidget child;
  final Color color;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: color,
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverPinnedHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.color != color;
  }
}
