import 'package:dolin/app/modules/practice/custom_paint/tool/coordinate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double _kDefaultSpringHeight = 200; // 弹簧默认高度
const double _kRateOfMove =
    1.5; // 移动距离与形变量比值 (手指向下移动了 15 个逻辑像素，弹簧形变量为 10 个逻辑像素)
const double _kSpringWidth = 80; // 弹簧高度

class Spring extends StatefulWidget {
  const Spring({super.key});

  @override
  State<Spring> createState() => _SpringState();
}

class _SpringState extends State<Spring> with SingleTickerProviderStateMixin {
  _SpringState() {
    debugPrint('_SpringState 构造函数');
    debugPrint('mounted：$mounted');
  }
  // 使用可监听对象来触发重绘，使可监听对象直接通知画板更新，期间没有任何的构建过程，是更高效触发重绘的手段
  ValueNotifier<double> height = ValueNotifier(_kDefaultSpringHeight);
  double s = 0; // 移动距离
  double laseMoveLen = 0;
  late Animation<double> _animation;
  late AnimationController _animationController;

  double get dx => -s / _kRateOfMove;

  void _updateHeight(DragUpdateDetails details) {
    s += details.delta.dy;
    height.value = _kDefaultSpringHeight + dx;
  }

  void _updateHeightByAnim() {
    s = laseMoveLen * (1 - _animation.value);
    height.value = _kDefaultSpringHeight + dx;
  }

  void _animateToDefault(DragEndDetails details) {
    laseMoveLen = s;
    _animationController.forward(from: 0);
  }

  @override
  void initState() {
    debugPrint('initState mounted：$mounted');

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        _updateHeightByAnim();
      });
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);

    super.initState();
  }

  @override
  void dispose() {
    height.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spring'),
      ),
      body: GestureDetector(
        onVerticalDragUpdate: _updateHeight,
        onVerticalDragEnd: _animateToDefault,
        child: SafeArea(
          child: SizedBox.expand(
            child: CustomPaint(
              painter: Painter(height: height),
            ),
          ),
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  Painter({required this.height, this.count = 20}) : super(repaint: height);
  // 将 height 类型定义为 ValueListenable<double> ，并通过 super(repaint: height) 将画板与可监听对象绑定。
  // 这样，当 height 值发生变化，就会通知直接画板重绘
  final ValueListenable<double> height;
  final int count;

  @override
  void paint(Canvas canvas, Size size) {
    Coordinate().paint(canvas, size);
    canvas.translate(size.width / 2 - _kSpringWidth / 2, size.height / 2);
    final double space = height.value / count;
    final Path path = Path()..relativeLineTo(_kSpringWidth, 0);
    for (int i = 1; i < count; i++) {
      if ((i % 2).isOdd) {
        path.relativeLineTo(-_kSpringWidth, -space);
      } else {
        path.relativeLineTo(_kSpringWidth, -space);
      }
    }
    if ((count % 2) == 0) {
      path.relativeLineTo(_kSpringWidth, 0);
    } else {
      path.relativeLineTo(-_kSpringWidth, 0);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant Painter oldDelegate) {
    return oldDelegate.count != count || oldDelegate.height != height;
  }
}

/// 自定义插值器
class Interpolator extends Curve {
  const Interpolator();

  @override
  double transformInternal(double t) {
    t -= 1.0;
    return t * t * t * t * t + 1.0;
  }
}
