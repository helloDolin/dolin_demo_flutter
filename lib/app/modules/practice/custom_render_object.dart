// ignore_for_file: cascade_invocations

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomRenderObject extends StatelessWidget {
  const CustomRenderObject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomRenderObject'),
      ),
      body: Column(
        children: [
          const Text(
            'overflowed by 100 pixels\n主要是由 DebugOverflowIndicatorMixin 控制 \n 100也是手动传的',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF000000),
            ),
          ),
          const SizedBox(height: 50),
          Container(
            color: Colors.red[200],
            child: const ShadowBox(
              // distance: 3,
              child: Icon(
                Icons.holiday_village,
                size: 280,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShadowBox extends SingleChildRenderObjectWidget {
  const ShadowBox({this.distance = 10, super.key, super.child});
  final double distance;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderShadowBox(distance);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderShadowBox renderObject,
  ) {
    renderObject.distance = distance;
  }
}

// class RenderShadowBox extends RenderBox with RenderObjectWithChildMixin {
class RenderShadowBox extends RenderProxyBox with DebugOverflowIndicatorMixin {
  RenderShadowBox(this.distance);
  double distance;

  @override
  void performLayout() {
    // parentUsesSize 父要用子的尺寸，很重要的优化：relayout boundary，
    // 布局到这里就可以停住了，父不需要知道子尺寸时，设置为 false，提效
    child!.layout(constraints, parentUsesSize: true);
    // child!.layout(BoxConstraints.tight(const Size(50, 50)));
    // size = const Size(300, 300);
    // ignore: cast_nullable_to_non_nullable
    size = (child as RenderBox).size;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(child!, offset);

    // context.canvas.drawCircle(
    //   offset + Offset.zero,
    //   100,
    //   Paint()
    //     ..color = Colors.red
    //     ..strokeWidth = 1,
    // );
    context.pushOpacity(offset, 100, (context, offset) {
      context.paintChild(child!, offset + Offset(distance, distance));
    });

    // 所以警戒线、布局、约束跟渲染没有关系
    paintOverflowIndicator(
      context,
      offset,
      Offset.zero & size, // 构建一个 Rect
      Rect.fromLTWH(0, 0, size.width, size.height + 100),
    );
  }
}
