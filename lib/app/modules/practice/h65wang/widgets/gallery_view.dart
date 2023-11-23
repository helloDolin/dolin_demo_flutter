import 'package:flutter/material.dart';

class GalleryView extends StatefulWidget {
  GalleryView({
    required this.builder,
    super.key,
    this.scrollController,
    this.itemCount,
    this.initialPerRow = 3,
    this.minCrossAxisCount = 1,
    this.maxCrossAxisCount = 7,
    this.duration = const Duration(seconds: 1),
  }) : now = DateTime.now();

  GalleryView.build({
    required this.builder,
    super.key,
    this.scrollController,
    this.itemCount,
    this.initialPerRow = 3,
    this.minCrossAxisCount = 1,
    this.maxCrossAxisCount = 7,
    this.duration = const Duration(seconds: 1),
  })  : now = DateTime.now(),
        assert(minCrossAxisCount < 1, 'minCrossAxisCount 最小值为 1');

  final ScrollController? scrollController;
  final int? itemCount;
  final Widget Function(BuildContext context, int index) builder;
  final int initialPerRow;
  final int minCrossAxisCount;
  final int maxCrossAxisCount;
  final Duration duration;
  final DateTime now;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  late final ScrollController _scrollController =
      widget.scrollController ?? ScrollController();

  double _maxWidth = 0;
  double _size = 0; // item size
  double _prevSize = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth != _maxWidth) {
          _maxWidth = constraints.maxWidth;
          _size = _maxWidth / widget.initialPerRow;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _snapToGrid();
          });
        }
        return GestureDetector(
          onScaleStart: (_) {
            _scrollController.jumpTo(0);
            _prevSize = _size;
          },
          onScaleUpdate: (details) {
            final maxSize = _maxWidth / widget.minCrossAxisCount;
            final minSize = _maxWidth / widget.maxCrossAxisCount;
            setState(() {
              debugPrint('onScaleUpdate ${details.scale}');
              _size = (_prevSize * details.scale).clamp(minSize, maxSize);
            });
          },
          onScaleEnd: (_) => _snapToGrid(),
          child: _buildListView(),
        );
      },
    );
  }

  void _snapToGrid() {
    final countPerRow = (_maxWidth / _size)
        .round() // 四舍五入
        .clamp(widget.minCrossAxisCount, widget.maxCrossAxisCount);
    setState(() {
      _size = _maxWidth / countPerRow;
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    return SizedBox(
      width: _size,
      height: _size,
      child: AnimatedSwitcher(
        duration: widget.duration,
        child: KeyedSubtree(
          key: ValueKey(index),
          child: widget.builder(context, index),
        ),
      ),
    );
  }

  ListView _buildListView() {
    final countPerRow = (_maxWidth / _size).ceil();
    return ListView.builder(
      controller: _scrollController,
      itemExtent: _size,
      itemCount: widget.itemCount != null
          ? (widget.itemCount! / countPerRow).ceil()
          : null,
      itemBuilder: (BuildContext context, int index) {
        return OverflowBox(
          // 打破上级约束，为数不多的打破父级约束的组件
          maxWidth: double.infinity,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              for (int i = 0; i < countPerRow; i++)
                // 处理最后一行逻辑
                if (widget.itemCount == null ||
                    index * countPerRow + i < widget.itemCount!)
                  _buildItem(context, index * countPerRow + i)
            ],
          ),
        );
      },
    );
  }
}
