import 'dart:math';

import 'package:flutter/material.dart';

class KeyPractice extends StatefulWidget {
  const KeyPractice({super.key});

  @override
  State<KeyPractice> createState() => _KeyPracticeState();
}

class _KeyPracticeState extends State<KeyPractice> {
  var _color = Colors.blue;
  var _colors = <Color>[];
  int _dragIndex = 0;
  final _stackGlobalKey = GlobalKey();
  double _stackTopPadding = 0.0;

  void _shuffle() {
    // Color obj1 = Colors.blue[900]!;
    // Color obj2 = Colors.blue[100]!;
    // print(obj1.computeLuminance());
    // print(obj2.computeLuminance());

    // return;
    _color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    _colors = List.generate(4, (i) => _color[(i + 1) * 100]!);
    setState(() {
      _colors.shuffle();
    });
  }

  void checkWinStatus() {
    bool res = true;
    for (var i = 1; i < _colors.length; i++) {
      Color colorPre = _colors[i - 1];
      Color colorCur = _colors[i];
      double computeLuminancePre = colorPre.computeLuminance();
      double computeLuminanceCur = colorCur.computeLuminance();
      // computeLuminance() 颜色越亮值越大
      if (computeLuminancePre > computeLuminanceCur) {
        res = false;
        break;
      }
    }
    print(res);
  }

  @override
  void initState() {
    _shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeyPractice'),
        actions: [
          TextButton(
            onPressed: _shuffle,
            child: const Text('shuffle'),
          ),
        ],
      ),
      body: Container(
        // color: Colors.orange,
        child: Center(
          child: Column(
            children: [
              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text('第一个不能挪动'),
              // ),
              Container(
                decoration: BoxDecoration(
                    color: _colors.isEmpty ? Colors.white : _color[900],
                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                alignment: Alignment.center,
                width: Box.boxWidth - Box.margin * 2,
                height: Box.boxHeight - Box.margin * 2,
                child: const Icon(Icons.lock_clock_outlined),
              ),
              const SizedBox(
                height: Box.margin * 2,
              ),
              Expanded(
                child: SizedBox(
                  // width: Box.boxWidth - Box.margin * 2,
                  child: Listener(
                    onPointerMove: (event) {
                      final x = event.position.dx;
                      if (x > (_dragIndex + 1) * Box.boxWidth) {
                        if (_dragIndex == _colors.length - 1) return;
                        setState(() {
                          final c = _colors[_dragIndex];
                          _colors[_dragIndex] = _colors[_dragIndex + 1];
                          _colors[_dragIndex + 1] = c;
                          // _dragIndex++;
                        });
                      } else if (x < _dragIndex * Box.boxWidth) {
                        if (_dragIndex == 0) return;
                        setState(() {
                          final c = _colors[_dragIndex];
                          _colors[_dragIndex] = _colors[_dragIndex - 1];
                          _colors[_dragIndex - 1] = c;
                          // _dragIndex--;
                        });
                      }
                    },
                    child: Stack(
                      key: _stackGlobalKey,
                      alignment: Alignment.center,
                      children: [
                        ...List.generate(
                          _colors.length,
                          (index) => Box(
                            onDragEnd: () {
                              RenderBox renderBox = _stackGlobalKey
                                  .currentContext!
                                  .findRenderObject() as RenderBox;
                              final offset =
                                  renderBox.localToGlobal(Offset.zero);
                              _stackTopPadding = offset.dy;
                              checkWinStatus();
                            },
                            onDragStarted: (Color color) {
                              final index = _colors.indexOf(color);
                              _dragIndex = index;
                            },
                            color: _colors[index],
                            x: index * Box.boxWidth,
                            y: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Box extends StatelessWidget {
  static const double boxWidth = 50.0;
  static const double boxHeight = 100.0;
  static const double margin = 8.0;

  Box({
    // super.key,
    required this.color,
    required this.x,
    required this.y,
    required this.onDragStarted,
    required this.onDragEnd,
  }) : super(key: ValueKey(color));
  final Color color;
  final double x;
  final double y;
  final Function(Color color) onDragStarted;
  final Function() onDragEnd;

  @override
  Widget build(BuildContext context) {
    final container = Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(6))),
      alignment: Alignment.center,
      width: boxWidth - margin * 2,
      height: boxHeight - margin * 2,
    );

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      top: y,
      left: x,
      child: Draggable(
        onDragStarted: () {
          onDragStarted(color);
        },
        onDragEnd: (_) {
          onDragEnd();
        },
        childWhenDragging: Visibility(
          visible: false,
          child: container,
        ),
        feedback: container,
        child: container,
      ),
    );
  }
}
