import 'dart:async';

import 'package:flutter/material.dart';

/// 初始索引偏移量
const int _kIndexOffset = 10000;

class Swiper extends StatefulWidget {
  const Swiper({
    required this.children,
    required this.onTapChild,
    super.key,
    this.autoPlay = true,
  });

  final List<Widget> children;
  final void Function(int index) onTapChild;
  final bool autoPlay;

  @override
  State<Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  /// 局部更新
  ValueNotifier<int> activePageIndex = ValueNotifier<int>(0);

  /// PageController
  late PageController _pageController;

  /// 实际下标
  int _realIndex = 0;

  /// 保证初始化下标大于 _kIndexOffset
  int get initOffsetIndex =>
      (_kIndexOffset ~/ widget.children.length + 1) * widget.children.length;

  /// timer
  late Timer _timer;

  /// 是否自动播放
  late bool _shouldAutoPlay;

  // 根据 _realIndex 计算出显示第几个界面
  int get currentPage {
    // 计算滑动的索引偏移量
    final int offsetIndex = _realIndex - initOffsetIndex;
    return offsetIndex % widget.children.length;
  }

  @override
  void initState() {
    super.initState();
    _realIndex = initOffsetIndex + _realIndex;
    _pageController = PageController(
      initialPage: _realIndex,
    );
    if (widget.autoPlay) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_shouldAutoPlay) {
          _pageController.animateToPage(
            _realIndex + 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 180,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: PageView.builder(
              // pageSnapping: false,
              controller: _pageController,
              onPageChanged: (int page) {
                _realIndex = page;
                activePageIndex.value = currentPage;
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTapDown: (_) {
                    _shouldAutoPlay = false;
                    widget.onTapChild(currentPage);
                  },
                  onTapUp: (_) => _shouldAutoPlay = true,
                  onTapCancel: () => _shouldAutoPlay = true,
                  child: widget.children[index % widget.children.length],
                  // child: Container(
                  //   color: Colors.primaries[index % Colors.primaries.length],
                  // ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: ValueListenableBuilder(
              valueListenable: activePageIndex,
              builder: (context, value, child) {
                return Center(
                  child: PageIndicator(
                    length: widget.children.length,
                    activeIndex: value,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: ValueListenableBuilder(
              valueListenable: activePageIndex,
              builder: (_, int pageIndex, __) {
                return Text(
                  '${pageIndex + 1}/${widget.children.length}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFFFFFF),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    required this.length,
    required this.activeIndex,
    super.key,
    this.size = 5,
  });

  final int length;
  final int activeIndex;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: size,
      children: List.generate(length, (index) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: activeIndex == index ? Colors.white : Colors.grey,
          ),
        );
      }),
    );
  }
}
