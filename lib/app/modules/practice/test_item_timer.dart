import 'dart:async';

import 'package:flutter/material.dart';

class TestItemTimer extends StatefulWidget {
  const TestItemTimer({super.key});

  @override
  State<TestItemTimer> createState() => _TestItemTimerState();
}

class _TestItemTimerState extends State<TestItemTimer> {
  late Timer _timer;
  List<int> testArr = [];
  @override
  void initState() {
    super.initState();
    testArr = List.generate(100, (index) => index + 10);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print(timer.tick);
      // list 中所有数据 -1
      for (var i = 0; i < testArr.length; i++) {
        if (testArr[i] > 0) {
          testArr[i] = testArr[i] - 1;
        }
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('item_timer'),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemBuilder: (context, index) {
            int num = testArr[index];
            return Item(
              countdown: num,
            );
          },
          itemCount: testArr.length,
        ));
  }
}

class Item extends StatelessWidget {
  const Item({super.key, required this.countdown});
  final int countdown;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 40,
      child: Text(
        countdown.toString(),
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: Colors.primaries[countdown % Colors.primaries.length],
        ),
      ),
    );
  }
}
