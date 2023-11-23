// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatePractice extends StatefulWidget {
  const AnimatePractice({super.key});

  @override
  State<AnimatePractice> createState() => _AnimatePracticeState();
}

class _AnimatePracticeState extends State<AnimatePractice>
    with SingleTickerProviderStateMixin {
  // 如果要用到多个 ticker 需要 with TickerProviderStateMixin（去掉 single）
  // ticker，singleTicker
  int _count = 0;
  bool _isAnimating = false;
  late final List<Snow> _snows = List.generate(1000, (index) => Snow());

  final slidingBoxCount = 3;
  final slidingInterval = 1 / 5;
  late final AnimationController _ac = AnimationController(
    vsync: this, // 屏幕刷新时可以得到一次回传,eg:一秒回传 60 或者 120 次
    duration: const Duration(seconds: 1),
  )..addListener(() {
      debugPrint('animation controller value: ${_ac.value}');
    });

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final opacityAnimation = Tween(begin: 0.5, end: 0.8).animate(_ac);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatePractice'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                ),

                Wrap(
                  spacing: 3,
                  children: [
                    const AnimatedCounter(
                      count: 100,
                      duration: Duration(milliseconds: 300),
                    ),
                    const AnimatedCounter(
                      count: 2,
                      duration: Duration(milliseconds: 300),
                    ),
                    AnimatedCounter(
                      count: _count,
                      duration: const Duration(milliseconds: 300),
                    ),
                  ],
                ),
                // 显示动画
                RotationTransition(
                  // scale: _ac,
                  // position: _ac.drive(
                  //     Tween(begin: const Offset(0, 0), end: const Offset(1, 1))),
                  turns: _ac,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                ),
                ...[
                  for (int i = 0; i < slidingBoxCount; i++)
                    SlidingBox(
                      ac: _ac,
                      color: Colors.blue[i * 100 + 100] ?? Colors.red,
                      interval: Interval(
                        i * slidingInterval,
                        i * slidingInterval + slidingInterval,
                      ),
                    ),
                ],
                AnimatedBuilder(
                  animation: _ac,
                  // child: child,
                  builder: (BuildContext context, Widget? child) {
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [Colors.blue[600]!, Colors.blue[100]!],
                          stops: [_ac.value, _ac.value + 0.1],
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _ac,
                  child: const Center(
                    child: Text(
                      'Hello',
                      style: TextStyle(fontSize: 36),
                    ),
                  ),
                  builder: (BuildContext context, Widget? child) {
                    // 这里的 child 即为上面的 child，传入不参与动画的组件以提升性能
                    return Opacity(
                      opacity: opacityAnimation.value,
                      child: Container(
                        color: Colors.amber[100],
                        width: 300,
                        height:
                            Tween<double>(begin: 50, end: 100).evaluate(_ac),
                        child: child,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // 飘雪花
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: AnimatedBuilder(
              animation: _ac,
              builder: (context, child) {
                for (final element in _snows) {
                  element.fall();
                }
                return CustomPaint(
                  painter: MyPainter(_snows),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  _isAnimating ? _ac.stop() : _ac.repeat(reverse: true);
                  setState(() {
                    _isAnimating = !_isAnimating;
                  });
                  // _ac.duration = const Duration(seconds: 4);
                  // _ac.forward();
                  // await Future.delayed(const Duration(seconds: 4));

                  // await Future.delayed(const Duration(seconds: 7));

                  // _ac.duration = const Duration(seconds: 8);
                  // _ac.reverse();
                },
                child: Text(_isAnimating ? '停止动画' : '运行动画'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _count++;
                  });
                },
                child: const Text('数字加一'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SlidingBox extends StatelessWidget {
  const SlidingBox({
    required AnimationController ac,
    required this.color,
    required this.interval,
    super.key,
  }) : _ac = ac;

  final AnimationController _ac;
  final Color color;
  final Interval interval;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(begin: Offset.zero, end: const Offset(0.1, 0))
          .chain(CurveTween(curve: interval))
          .chain(CurveTween(curve: Curves.bounceInOut))
          .animate(_ac),
      child: Container(
        width: 300,
        height: 50,
        color: color,
      ),
    );
  }
}

class AnimatedCounter extends StatelessWidget {
  const AnimatedCounter({
    required this.count,
    required this.duration,
    super.key,
    this.fontSize = 100.0,
  });
  final int count;
  final Duration duration;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      builder: (BuildContext context, double value, Widget? child) {
        var whole = value ~/ 1;
        final decimal = value - whole;
        if (whole > 99) whole = 99;
        debugPrint('whole,decimal:$whole,$decimal');
        return Container(
          color: Colors.blue[300],
          height: fontSize + 20,
          width: fontSize + 20,
          child: DefaultTextStyle(
            style: TextStyle(fontSize: fontSize, color: Colors.white),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -fontSize * decimal,
                  child: Opacity(
                    opacity: 1 - decimal, // 1 - 0 越来越淡
                    child: Text(
                      whole.toString(),
                    ),
                  ), // 0 - -100
                ),
                Positioned(
                  top: fontSize - decimal * fontSize, // 100 - 0
                  child: Opacity(
                    opacity: decimal, // 0 - 1 越来越清晰
                    child: Text(
                      (whole + 1).toString(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      duration: duration,
      tween: Tween(end: count.toDouble()),
      // Tween(begin: 1.0, end: 10.0), // 从 1 - 10，不想要效果，就把 begin 和 end 设置为一样
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Snow> _snows;
  MyPainter(this._snows);
  @override
  void paint(Canvas canvas, Size size) {
    final whitePaint = Paint()..color = Colors.green[100]!;
    for (final element in _snows) {
      canvas.drawCircle(
        Offset(element.x, element.y),
        element.radius,
        whitePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Snow {
  double y = Random().nextDouble() * ScreenUtil().screenHeight;
  double x = Random().nextDouble() * ScreenUtil().screenWidth;
  double radius = Random().nextDouble() * 2 + 2;
  double velocity = Random().nextDouble() * 4 + 2;

  void fall() {
    y += velocity;
    if (y >
        ScreenUtil().screenHeight -
            ScreenUtil().statusBarHeight -
            ScreenUtil().bottomBarHeight) {
      y = 0;
      x = Random().nextDouble() * ScreenUtil().screenWidth;
      radius = Random().nextDouble() * 2 + 2;
      velocity = Random().nextDouble() * 4 + 2;
    }
  }
}
