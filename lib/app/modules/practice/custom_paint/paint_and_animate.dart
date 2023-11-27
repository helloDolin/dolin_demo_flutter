import 'dart:ui' as ui;

import 'package:dolin/app/modules/practice/custom_paint/tool/coordinate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {
  late AnimationController _ac;
  late Animation<double> _speedAnimation;

  ui.Image? _img;

  // 读取 assets 中的图片
  Future<ui.Image>? loadImageFromAssets(String path) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(bytes);
  }

  Future<void> _loadImage() async {
    _img = await loadImageFromAssets('assets/images/logo.png');
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadImage();
    });

    // AnimationController 的构造器中需要传入TickerProvider对象可以将 State 对象混入SingleTickerProviderStateMixin 来成为该对象
    _ac = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _speedAnimation = CurveTween(curve: Curves.easeIn).animate(_ac);
    _ac
      ..forward()
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制+动画'),
      ),
      body: SizedBox.expand(
        child: CustomPaint(
          painter: PaperPainter(_ac, _img, _speedAnimation),
        ),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  // 重点：CustomPainter 中有一个 _repaint 的 Listenable 对象。当监听到这个对象的变化时，画板会触发重绘，这是触发重绘的最高效的方式。
  // 传入 Listenable 可监听对象
  PaperPainter(this.progress, this.img, this.speed) : super(repaint: progress);
  // 定义成员变量
  final Animation<double> progress;
  final Animation<double> speed;

  ui.Image? img;

  Coordinate coordinate = Coordinate();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    final Paint paint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close()
      ..addOval(Rect.fromCenter(center: Offset.zero, width: 50, height: 50))
      ..addOval(Rect.fromCenter(center: Offset.zero, width: 200, height: 200));

    final ui.PathMetrics pathMetrics = path.computeMetrics();
    for (final element in pathMetrics) {
      final ui.Tangent? tangent =
          element.getTangentForOffset(element.length * speed.value); // 使用动画器的值
      if (tangent == null || img == null) continue;
      // canvas.drawCircle(
      //   tangent.position,
      //   5,
      //   Paint()..color = Colors.deepOrange,
      // );
      canvas.drawImage(
        img!,
        Offset(
          tangent.position.dx - imgW / 2,
          tangent.position.dy - imgH / 2,
        ),
        Paint(),
      );
    }

    canvas.drawPath(path, paint);
  }

  double get imgW => img?.width.toDouble() ?? 0;
  double get imgH => img?.height.toDouble() ?? 0;

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
