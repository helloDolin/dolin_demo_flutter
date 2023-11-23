// ignore_for_file: cascade_invocations

import 'package:flutter/material.dart';

/// 坐标
class Coordinate {
  Coordinate({
    this.step = 20,
    this.strokeWidth = .5,
    this.axisColor = Colors.blue,
    this.gridColor = Colors.grey,
  });
  final double step;

  /// 画笔粗细
  final double strokeWidth;

  /// 轴颜色
  final Color axisColor;

  /// 网格颜色
  final Color gridColor;

  final TextPainter _textPainter =
      TextPainter(textDirection: TextDirection.ltr);

  final Paint _gridPaint = Paint();

  void paint(Canvas canvas, Size size) {
    canvas.save(); // 不影响外部的使用
    // 画布中心点移到中心点
    // 重点：坐标系(0,0)点为中心点
    canvas.translate(size.width / 2, size.height / 2);

    _drawGridLine(canvas, size);
    _drawAxis(canvas, size);
    _drawText(canvas, size);

    canvas.restore(); // 画纸移动后，调用此方法，让画纸回到初始状态
  }

  void _drawGridLine(Canvas canvas, Size size) {
    final Path path = Path();

    _gridPaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = gridColor;

    // eg：以 Size（100,100） 距离，先到 (0,-50) 左边，再以这个坐标画线
    // path.moveTo(0, -size.height / 2);
    // path.relativeLineTo(0, size.height);

    // 竖线
    for (int i = 0; i < size.width / 2 / step; i++) {
      // 右侧竖线
      path.moveTo(step * i, -size.height / 2);
      path.relativeLineTo(0, size.height); // relative 相对当前坐标
      // 左侧竖线
      path.moveTo(-step * i, -size.height / 2);
      path.relativeLineTo(0, size.height);
    }

    for (int i = 0; i < size.height / 2 / step; i++) {
      // 下方横线
      path.moveTo(-size.width / 2, step * i);
      path.relativeLineTo(size.width, 0);
      // 上方横线
      path.moveTo(-size.width / 2, -step * i);
      path.relativeLineTo(size.width, 0);
    }

    canvas.drawPath(path, _gridPaint);
  }

  void _drawAxis(Canvas canvas, Size size) {
    _gridPaint
      ..color = Colors.blue
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(-size.width / 2, 0),
      Offset(size.width / 2, 0),
      _gridPaint,
    );
    canvas.drawLine(
      Offset(0, -size.height / 2),
      Offset(0, size.height / 2),
      _gridPaint,
    );
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(0 - 7.0, size.height / 2 - 10),
      _gridPaint,
    );
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(0 + 7.0, size.height / 2 - 10),
      _gridPaint,
    );
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2 - 10, 7),
      _gridPaint,
    );
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2 - 10, -7),
      _gridPaint,
    );
  }

  void _drawText(Canvas canvas, Size size) {
    // y > 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(0, step);
        continue;
      } else {
        final str = (i * step).toInt().toString();
        _drawAxisText(canvas, str, color: Colors.green);
      }
      canvas.translate(0, step);
    }
    canvas.restore();

    // x > 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      if (i == 0) {
        _drawAxisText(canvas, 'O', x: null);
        canvas.translate(step, 0);
        continue;
      }
      if (step < 30 && i.isOdd) {
        canvas.translate(step, 0);
        continue;
      } else {
        final str = (i * step).toInt().toString();
        _drawAxisText(canvas, str, color: Colors.green, x: true);
      }
      canvas.translate(step, 0);
    }
    canvas.restore();

    // y < 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(0, -step);
        continue;
      } else {
        final str = (-i * step).toInt().toString();
        _drawAxisText(canvas, str, color: Colors.green);
      }

      canvas.translate(0, -step);
    }
    canvas.restore();

    // x < 0 轴 文字
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(-step, 0);
        continue;
      } else {
        final str = (-i * step).toInt().toString();
        _drawAxisText(canvas, str, color: Colors.green, x: true);
      }
      canvas.translate(-step, 0);
    }
    canvas.restore();
  }

  void _drawAxisText(
    Canvas canvas,
    String str, {
    Color color = Colors.black,
    bool? x = false,
  }) {
    final TextSpan text = TextSpan(
      text: str,
      style: TextStyle(
        fontSize: 11,
        color: color,
      ),
    );

    _textPainter.text = text;
    _textPainter.layout(); // 进行布局
    final Size size = _textPainter.size;
    Offset offset = Offset.zero;
    if (x == null) {
      offset = Offset(-size.width * 1.5, size.width * 0.7);
    } else if (x) {
      offset = Offset(-size.width / 2, size.height / 2);
    } else {
      offset = Offset(size.height / 2, -size.height / 2 + 2);
    }
    _textPainter.paint(canvas, offset);
  }
}
