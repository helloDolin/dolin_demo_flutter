import 'dart:ui';

import 'package:flutter/material.dart';

import 'tool/coordinate.dart';

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    // 第一帧绘制结束回调
    WidgetsBinding.instance.addPostFrameCallback((Duration d) {
      debugPrint('第一帧回调$d');
    });
    // AnimationController 的构造器中需要传入TickerProvider对象可以将 State 对象混入SingleTickerProviderStateMixin 来成为该对象
    _ctrl =
        AnimationController(duration: const Duration(seconds: 3), vsync: this)
          ..forward()
          ..repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制+动画'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
          painter: PaperPainter(_ctrl),
        ),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  // 定义成员变量
  final Animation<double> progress;

  // 重点：CustomPainter 中有一个 _repaint 的 Listenable 对象。当监听到这个对象的变化时，画板会触发重绘，这是触发重绘的最高效的方式。
  // 传入 Listenable 可监听对象
  PaperPainter(this.progress) : super(repaint: progress);
  Coordinate coordinate = Coordinate();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();

    path.addOval(Rect.fromCenter(center: Offset.zero, width: 50, height: 50));

    path.addOval(Rect.fromCenter(center: Offset.zero, width: 200, height: 200));

    PathMetrics pathMetrics = path.computeMetrics();
    for (var element in pathMetrics) {
      Tangent? tangent = element
          .getTangentForOffset(element.length * progress.value); // 使用动画器的值
      if (tangent == null) continue;
      canvas.drawCircle(
          tangent.position, 5, Paint()..color = Colors.deepOrange);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
