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
      body: Container(
        color: Colors.red[200],
        child: const ShadowBox(
          // distance: 3,
          child: Icon(
            Icons.holiday_village,
            size: 80,
          ),
        ),
      ),
    );
  }
}

/// SingleChildRenderObjectWidget 真正可以画到屏幕上的 Widget
class ShadowBox extends SingleChildRenderObjectWidget {
  const ShadowBox({this.distance = 10, super.key, Widget? child})
      : super(child: child);
  final double distance;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderShadowBox(distance);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderShadowBox renderObject) {
    // 有改动时告之，否知 hotreload 无效
    renderObject.distance = distance;
  }
}

// class RenderShadowBox extends RenderBox with RenderObjectWithChildMixin {
class RenderShadowBox extends RenderProxyBox with DebugOverflowIndicatorMixin {
  double distance;

  RenderShadowBox(this.distance);

  @override
  void performLayout() {
    // parentUsesSize 父要用子的尺寸，很重要的优化：relayout boundary，
    // 布局到这里就可以停住了，父不需要知道子尺寸时，设置为 false，提效
    child!.layout(constraints, parentUsesSize: true);
    // child!.layout(BoxConstraints.tight(const Size(50, 50)));
    // size = const Size(300, 300);
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
    context.pushOpacity(offset, 123, (context, offset) {
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
