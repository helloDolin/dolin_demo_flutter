import 'package:flutter/material.dart';

class AnimatePractice extends StatefulWidget {
  const AnimatePractice({super.key});

  @override
  State<AnimatePractice> createState() => _AnimatePracticeState();
}

class _AnimatePracticeState extends State<AnimatePractice> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatePractice'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            Wrap(
              spacing: 3,
              children: [
                const AnimatedCounter(
                  count: 1,
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
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _count++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AnimatedCounter extends StatelessWidget {
  const AnimatedCounter({
    super.key,
    required this.count,
    required this.duration,
    this.fontSize = 100.0,
  });
  final int count;
  final Duration duration;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      builder: (BuildContext context, double value, Widget? child) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        print('whole,decimal:$whole,$decimal');
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
