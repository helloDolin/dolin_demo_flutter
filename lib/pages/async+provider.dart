// ignore_for_file: file_names

import 'dart:async';

import 'package:dolin_demo_flutter/model/counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AsyncPage extends StatefulWidget {
  const AsyncPage({Key? key}) : super(key: key);

  @override
  State<AsyncPage> createState() => _AsyncPageState();
}

class _AsyncPageState extends State<AsyncPage> {
  void test1() {
    Future(() => debugPrint('Running in Future 1')); // 下一个事件循环输出字符串
    Future(() => debugPrint('Running in Future 2'))
        .then((_) => debugPrint('and then 1'))
        .then((_) => debugPrint('and then 2')); // 上一个事件循环结束后，连续输出三段字符串
    debugPrint('123');
  }

  void test2() {
    // f1 比 f2 先执行
    Future(() => debugPrint('f1'));
    Future(() => debugPrint('f2'));

    // f3 执行后会立刻同步执行 then 3
    Future(() => debugPrint('f3')).then((_) => debugPrint('then 3'));

    // then 4 会加入微任务队列，尽快执行
    Future(() => null).then((_) => debugPrint('then 4'));
  }

  void test3() {
    Future(() => debugPrint('f1')); // 声明一个匿名 Future
    Future fx = Future(() => null); // 声明 Future fx，其执行体为 null

    // 声明一个匿名 Future，并注册了两个 then。在第一个 then 回调里启动了一个微任务
    Future(() => debugPrint('f2')).then((_) {
      debugPrint('f3');
      scheduleMicrotask(() => debugPrint('f4'));
    }).then((_) => debugPrint('f5'));

    // 声明了一个匿名 Future，并注册了两个 then。第一个 then 是一个 Future
    Future(() => debugPrint('f6'))
        .then((_) => Future(() => debugPrint('f7')))
        .then((_) => debugPrint('f8'));

    // 声明了一个匿名 Future
    Future(() => debugPrint('f9'));

    // 往执行体为 null 的 fx 注册了了一个 then
    fx.then((_) => debugPrint('f10'));

    // 启动一个微任务
    scheduleMicrotask(() => debugPrint('f11'));
    debugPrint('f12');
  }

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AsyncPage'),
      ),
      body: Center(
        child: Text(counter.counter.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
