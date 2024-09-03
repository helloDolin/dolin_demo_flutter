import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class StreamGame extends StatefulWidget {
  const StreamGame({super.key});

  @override
  State<StreamGame> createState() => _CalculateGameState();
}

class _CalculateGameState extends State<StreamGame> {
  // 传递键盘输入
  late StreamController inputStreamController = StreamController.broadcast();
  // 更新分数
  late StreamController scoreController = StreamController.broadcast();

  @override
  void dispose() {
    inputStreamController.close();
    scoreController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Poker算数',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: List.generate(
                5,
                (index) => Puzzle(
                  inputStream: inputStreamController.stream,
                  scoreController: scoreController,
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: scoreController.stream.transform(MyStreamTransformer()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  '当前得分为：${snapshot.data}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFFFFF),
                  ),
                );
              }
              return const Text(
                '当前得分为:0',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFFFFFF),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: KeyPanel(inputStreamController: inputStreamController),
          ),
        ],
      ),
    );
  }
}

/// 键盘
class KeyPanel extends StatelessWidget {
  const KeyPanel({required this.inputStreamController, super.key});
  final StreamController inputStreamController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 3 / 1,
        children: List.generate(9, (index) {
          return InkWell(
            onTap: () {
              inputStreamController.add(index + 1);
            },
            child: Container(
              alignment: Alignment.center,
              color: Colors.primaries[index][200],
              child: Text((index + 1).toString()),
            ),
          );
        }),
      ),
    );
  }
}

/// 谜题
class Puzzle extends StatefulWidget {
  const Puzzle({
    required this.inputStream,
    required this.scoreController,
    super.key,
  });
  final Stream inputStream;
  final StreamController scoreController;

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with SingleTickerProviderStateMixin {
  late int _a;
  late int _b;
  late Color _color;
  late double _x;

  late final AnimationController _ac = AnimationController(vsync: this)
    ..duration =
        Duration(milliseconds: (Random().nextDouble() * 5000).toInt() + 5000)
    ..forward(from: 0)
    ..addListener(() {
      if (_ac.isCompleted) {
        // 减分
        _ac.forward(from: 0);
        widget.scoreController.add(-3);
      }
    });

  @override
  void initState() {
    _reset();

    widget.inputStream.listen((event) {
      // 加分
      if (event == _a + _b) {
        _reset();
        _ac.forward(from: 0);
        widget.scoreController.add(5);
      }
    });
    super.initState();
  }

  void _reset() {
    _a = Random().nextInt(5) + 1;
    _b = Random().nextInt(5);
    _color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    _x = Random().nextDouble() * 300.0;
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ac,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          left: _x,
          top: 400 * _ac.value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: _color.withOpacity(0.5),
            ),
            child: Text('$_a + $_b'),
          ),
        );
      },
    );
  }
}

class MyStreamTransformer implements StreamTransformer {
  int sum = 0;
  final StreamController _c = StreamController();
  @override
  Stream bind(Stream stream) {
    stream.listen((event) {
      sum += event as int;
      _c.add(sum);
    });
    return _c.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() => StreamTransformer.castFrom(this);
}
