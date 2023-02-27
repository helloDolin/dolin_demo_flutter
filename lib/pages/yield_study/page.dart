import 'package:flutter/material.dart';

/*
  ! yield 必须和 async* 或 sync* 配套使用
*/
class Page extends StatelessWidget {
  const Page({Key? key}) : super(key: key);

  // sync* 固定语法
  Iterable<int> getList(int count) sync* {
    // 带上 * 因为 yield 返回对象是 Iterable
    yield* generate(count);
    // for (int i = 0; i < count; i++) {
    //   yield i;
    // }
  }

  Iterable<int> generate(int count) sync* {
    for (int i = 0; i < count; i++) {
      yield i;
    }
  }

  Stream<int> getList2(int count) async* {
    yield* generate2(count);
    // for (int i = 0; i < count; i++) {
    //   await Future.delayed(Duration(seconds: 1));
    //   yield i;
    // }
  }

  Stream<int> generate2(int count) async* {
    for (int i = 0; i < count; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('yield study'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                getList(10).forEach(print);
              },
              child: const Text('yield 同步')),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                // getList2(10).forEach(print);
                getList2(10).listen(print);
              },
              child: const Text('yield 异步'))
        ],
      ),
    );
  }
}
