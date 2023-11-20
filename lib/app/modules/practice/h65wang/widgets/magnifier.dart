import 'package:flutter/material.dart';

/// 放大镜
class Magnifier extends StatefulWidget {
  const Magnifier({
    super.key,
    required this.child,
    this.magnification = 2.0,
  });

  final Widget child;

  /// 放大倍数
  final double magnification;

  @override
  State<Magnifier> createState() => _MagnifierState();
}

class _MagnifierState extends State<Magnifier> {
  Offset? _offset;

  Widget _buildBox(double dx, double dy, Size childSize) {
    final magnifierSize = childSize.shortestSide / 2;
    return Transform.translate(
      offset: Offset(dx - magnifierSize / 2, dy - magnifierSize / 2),
      child: Align(
        alignment: Alignment.topLeft,
        child: Stack(
          children: [
            // 内容
            SizedBox(
              width: magnifierSize,
              height: magnifierSize,
              child: ClipRect(
                child: Transform.scale(
                  scale: widget.magnification,
                  child: Transform.translate(
                    offset: Offset(
                      childSize.width / 2 - dx,
                      childSize.width / 2 - dy,
                    ),
                    child: OverflowBox(
                      minWidth: childSize.width,
                      maxWidth: childSize.width,
                      minHeight: childSize.height,
                      maxHeight: childSize.height,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
            // 边框
            Positioned.fill(
                child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 2),
                color: Colors.green.withOpacity(0.2),
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        // 利用 stack 布局特性，孩子里有非有位置组件和有位置组件时，stack 大小为非有位置组件最大的宽、高
        // 然后用 Positioned.fill 遮盖住
        Positioned.fill(
          child: LayoutBuilder(
            builder: (_, constraints) {
              final childSize = constraints.biggest;
              // 只适用于桌面或者 web
              // return MouseRegion(
              //   onHover: (event) {
              //     print(event);
              //     setState(() {
              //       _offset = event.localPosition;
              //     });
              //   },
              //   onExit: (_) {
              //     setState(() {
              //       _offset = null;
              //     });
              //   },
              //   child: _offset != null
              //       ? _buildBox(_offset!.dx, _offset!.dy, childSize)
              //       : null,
              // );
              return GestureDetector(
                onPanUpdate: (details) {
                  debugPrint('details ${details.localPosition}');
                  setState(() {
                    _offset = details.localPosition;
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    // _offset = null;
                  });
                },
                child: _offset != null
                    ? _buildBox(_offset!.dx, _offset!.dy, childSize)
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}
