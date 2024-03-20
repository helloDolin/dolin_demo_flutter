import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverSnapHeader extends StatefulWidget {
  const SliverSnapHeader({
    required this.child,
    super.key,
  });
  final PreferredSizeWidget child;

  @override
  State<SliverSnapHeader> createState() => _SliverSnapHeaderState();
}

class _SliverSnapHeaderState extends State<SliverSnapHeader>
    with TickerProviderStateMixin {
  FloatingHeaderSnapConfiguration? _snapConfiguration;
  PersistentHeaderShowOnScreenConfiguration? _showOnScreenConfiguration;

  void _initSnapConfiguration() {
    _snapConfiguration = FloatingHeaderSnapConfiguration(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 200),
    );

    _showOnScreenConfiguration =
        const PersistentHeaderShowOnScreenConfiguration(
      minShowOnScreenExtent: double.infinity,
    );
  }

  @override
  void initState() {
    super.initState();
    _initSnapConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: true,
      delegate: _SliverSnapHeaderDelegate(
        vsync: this,
        child: widget.child,
        snapConfiguration: _snapConfiguration,
        showOnScreenConfiguration: _showOnScreenConfiguration,
      ),
    );
  }
}

class _SliverSnapHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverSnapHeaderDelegate({
    required this.child,
    required this.snapConfiguration,
    required this.vsync,
    required this.showOnScreenConfiguration,
  });

  final PreferredSizeWidget child;

  @override
  final TickerProvider vsync;

  @override
  final FloatingHeaderSnapConfiguration? snapConfiguration;

  @override
  final PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverSnapHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        vsync != oldDelegate.vsync ||
        snapConfiguration != oldDelegate.snapConfiguration ||
        showOnScreenConfiguration != oldDelegate.showOnScreenConfiguration;
  }
}
