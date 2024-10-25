import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUpPanelPage extends StatelessWidget {
  const SlidingUpPanelPage({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('SlidingUpPanelExample'),
  //     ),
  //     body: Stack(
  //       children: <Widget>[
  //         const Center(
  //           child: Text('This is the Widget behind the sliding panel'),
  //         ),
  //         SlidingUpPanel(
  //           panel: const Center(
  //             child: Text('This is the sliding Widget'),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SlidingUpPanelExample'),
      ),
      body: SlidingUpPanel(
        panel: ColoredBox(
          color: Colors.red,
          child: Column(
            children: [
              Container(
                width: 100,
                height: 20,
                color: Colors.white,
              ),
              const Expanded(
                child: Center(
                  child: Text('This is the sliding Widget'),
                ),
              ),
            ],
          ),
        ),
        body: const ColoredBox(
          color: Colors.blue,
          child: Center(
            child: Text('This is the Widget behind the sliding panel'),
          ),
        ),
      ),
    );
  }
}
