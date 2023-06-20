import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SimulateClickPage extends StatelessWidget {
  const SimulateClickPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SimulateClickPage')),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ElevatedButton(
              child: const Text('big btn'),
              onPressed: () {
                print('tap big btn');
              },
            ),
          ),
          TextButton(
              onPressed: () {
                GestureBinding.instance.handlePointerEvent(
                    const PointerDownEvent(position: Offset(50, 300)));
                GestureBinding.instance.handlePointerEvent(
                    const PointerUpEvent(position: Offset(50, 300)));
              },
              child: const Text('模拟点击')),
        ],
      ),
    );
  }
}
