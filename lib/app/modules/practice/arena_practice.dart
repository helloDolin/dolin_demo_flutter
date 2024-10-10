import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ArenaPage extends StatefulWidget {
  const ArenaPage({super.key});

  @override
  State<ArenaPage> createState() => _ArenaPageState();
}

class _ArenaPageState extends State<ArenaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('点击子视图\n同时响应自己和父视图点击事件'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RawGestureDetector(
              gestures: {
                MultipleTapGestureRecognizer:
                    GestureRecognizerFactoryWithHandlers<
                        MultipleTapGestureRecognizer>(
                  () => MultipleTapGestureRecognizer(),
                  (MultipleTapGestureRecognizer instance) {
                    instance.onTap = () => debugPrint('parent tapped '); // 点击回调
                  },
                ),
              },
              child: ColoredBox(
                color: Colors.pinkAccent,
                child: Center(
                  child: GestureDetector(
                    // 子视图可以继续使用 GestureDetector
                    onTap: () => debugPrint('Child tapped'),
                    child: Container(
                      color: Colors.blueAccent,
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MultipleTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
