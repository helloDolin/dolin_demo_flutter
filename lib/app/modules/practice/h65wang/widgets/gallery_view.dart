import 'package:flutter/material.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({
    super.key,
    this.scrollController,
    this.itemCount,
    required this.builder,
    this.initialPerRow = 3,
    this.minCrossAxisCount = 1,
    this.maxCrossAxisCount = 7,
    this.duration = const Duration(seconds: 1),
  });
  final ScrollController? scrollController;
  final int? itemCount;
  final Function(BuildContext context, int index) builder;
  final int initialPerRow;
  final int minCrossAxisCount;
  final int maxCrossAxisCount;
  final Duration duration;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  late final ScrollController _scrollController =
      widget.scrollController ?? ScrollController();

  double _maxWidth = 0.0;
  double _size = 0.0; // item size
  double _prevSize = 0;

  _snapToGrid() {
    final countPerRow = (_maxWidth / _size)
        .round() // 四舍五入
        .clamp(widget.minCrossAxisCount, widget.maxCrossAxisCount);
    setState(() {
      _size = _maxWidth / countPerRow;
    });
  }

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
              print(details.scale);
              _size = (_prevSize * details.scale).clamp(minSize, maxSize);
            });
          },
          onScaleEnd: (details) => _snapToGrid(),
          child: _buildListView(),
        );
      },
    );
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
          child: Row(children: [
            for (int i = 0; i < countPerRow; i++)
              if (widget.itemCount == null ||
                  index * countPerRow + i < widget.itemCount!)
                _buildItem(context, index * countPerRow + i)
          ]),
        );
      },
    );
  }
}
