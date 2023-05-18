import 'dart:ui';

import 'package:dolin/app/modules/practice/custom_paint/tool/coordinate.dart';
import 'package:flutter/material.dart';

class BezierPage extends StatefulWidget {
  const BezierPage({super.key});

  @override
  State<BezierPage> createState() => _BezierPageState();
}

class _BezierPageState extends State<BezierPage> {
  final TouchInfo touchInfo = TouchInfo();

  @override
  void dispose() {
    touchInfo.dispose();
    super.dispose();
  }

  void _onPanDown(DragDownDetails details) {
    if (touchInfo.points.length < 3) {
      touchInfo.addPoint(details.localPosition);
    } else {
      judgeZone(details.localPosition);
    }
  }

  ///判断出是否在某点的半径为r圆范围内
  bool judgeCircleArea(Offset src, Offset dst, double r) =>
      (src - dst).distance <= r;

  //判断哪个点被选中
  void judgeZone(Offset src, {bool update = false}) {
    for (int i = 0; i < touchInfo.points.length; i++) {
      if (judgeCircleArea(src, touchInfo.points[i], 15)) {
        touchInfo.selectIndex = i;
        if (update) {
          touchInfo.updatePoint(i, src);
        }
      }
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    judgeZone(details.localPosition, update: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('贝塞尔曲线'),
      ),
      body: GestureDetector(
        onPanDown: _onPanDown,
        // onPanEnd: _onPanEnd,
        onPanUpdate: _onPanUpdate,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: CustomPaint(
            painter: Painter(touchInfo),
          ),
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  Painter(this.repaint) : super(repaint: repaint);

  final TouchInfo repaint;

  Coordinate coordinate = Coordinate();

  final Paint _helpPaint = Paint()
    ..color = Colors.purple
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
  List<Offset> pos = [];

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);

    canvas.translate(size.width / 2, size.height / 2);
    pos = repaint.points
        .map((e) => e.translate(-size.width / 2, -size.height / 2))
        .toList();
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    if (pos.length < 3) {
      canvas.drawPoints(PointMode.points, pos, _helpPaint..strokeWidth = 8);
    } else {
      path.moveTo(pos[0].dx, pos[0].dy);
      path.quadraticBezierTo(pos[1].dx, pos[1].dy, pos[2].dx, pos[2].dy);
      canvas.drawPath(path, paint);
      _drawHelp(canvas);
      _drawSelectPos(canvas, size);
    }
    _drawHelp(canvas);
  }

  void _drawSelectPos(Canvas canvas, Size size) {
    Offset? selectPos = repaint.selectPoint;
    if (selectPos == null) return;
    selectPos = selectPos.translate(-size.width / 2, -size.height / 2);
    canvas.drawCircle(
        selectPos,
        10,
        _helpPaint
          ..color = Colors.green
          ..strokeWidth = 2);
  }

  void _drawHelp(Canvas canvas) {
    _helpPaint.color = Colors.purple;
    canvas.drawPoints(PointMode.polygon, pos, _helpPaint..strokeWidth = 1);
    canvas.drawPoints(PointMode.points, pos, _helpPaint..strokeWidth = 8);
  }

  @override
  bool shouldRepaint(covariant Painter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate.repaint != repaint;
  }
}

// 由于画板需要一个 Listenable 对象来触发重绘，可以将需要改变的数据使用一个类维护起来。
// ChangeNotifier 是一个实现了 Listenable 的类。
// 在数据变动时，可以通过 notifyListeners() 来通知监听者，也就是画板对象，让它进行重绘
class TouchInfo extends ChangeNotifier {
  final List<Offset> _points = [];
  int _selectIndex = -1;

  int get selectIndex => _selectIndex;
  List<Offset> get points => _points;

  set selectIndex(int value) {
    if (_selectIndex == value) return;
    _selectIndex = value;
    notifyListeners();
  }

  void addPoint(Offset point) {
    points.add(point);
    notifyListeners();
  }

  void updatePoint(int index, Offset point) {
    points[index] = point;
    notifyListeners();
  }

  Offset? get selectPoint => _selectIndex == -1 ? null : _points[_selectIndex];
}
