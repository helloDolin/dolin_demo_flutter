import 'dart:ui';

import 'package:flutter/material.dart';

class BlurEffect extends StatelessWidget {
  const BlurEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '毛玻璃效果',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF000000),
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/btc_2_the_moon.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomPaint(
                    painter: GradientBoundPainter(
                      colors: [
                        const Color(0xFFFFFFFF).withOpacity(0.5),
                        const Color(0xFFFF48DB).withOpacity(0.5),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 40,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // gradient: LinearGradient(
                        //   colors: [
                        //     Colors.white.withOpacity(0.4),
                        //     Colors.white.withOpacity(0.1),
                        //   ],
                        //   begin: const Alignment(-1, -1),
                        //   end: const Alignment(0.3, 0.5),
                        // ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: const Color(0x00000000).withOpacity(0.1),
                        //     offset: const Offset(0, 1),
                        //     blurRadius: 24,
                        //     spreadRadius: -1,
                        //   ),
                        // ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'MEMBERSHIP',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            'GRAVITY TECHNOLOGY',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'SOFTMAX.TOOL',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GradientBoundPainter extends CustomPainter {
  const GradientBoundPainter({
    required this.colors,
    this.strokeWidth = 10.0,
  });
  final List<Color> colors;

  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 20.0;
    // 定义矩形的位置和尺寸
    final Rect rect = Offset.zero & Size(size.width, size.height);
    // RRect.fromRectAndRadius一个具有圆角的矩形
    final RRect rRect =
        RRect.fromRectAndRadius(rect, const Radius.circular(radius));
    // 绘制
    final paint = Paint()
      // 创建线性渐变着色器
      ..shader = LinearGradient(
        colors: colors,
      ).createShader(rect)
      ..strokeWidth = strokeWidth
      // 只绘制边框而不填充
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant GradientBoundPainter oldDelegate) {
    return oldDelegate.colors != colors;
  }
}
