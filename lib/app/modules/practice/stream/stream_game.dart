import 'package:flutter/material.dart';

class StreamGame extends StatelessWidget {
  const StreamGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamGame'),
      ),
      body: Stack(
        children: const [
          Align(
            alignment: Alignment.bottomLeft,
            child: KeyPannel(),
          )
        ],
      ),
    );
  }
}

class KeyPannel extends StatelessWidget {
  const KeyPannel({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 3 / 1,
        children: List.generate(9, (index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.primaries[index][200],
            child: Text((index + 1).toString()),
          );
        }),
      ),
    );
  }
}
