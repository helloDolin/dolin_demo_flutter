import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class AsyncPage extends StatefulWidget {
  const AsyncPage({Key? key}) : super(key: key);

  @override
  State<AsyncPage> createState() => _AsyncPageState();
}

class _AsyncPageState extends State<AsyncPage> {
  void test1() {
    Future(() => print('Running in Future 1')); // 下一个事件循环输出字符串
    Future(() => print('Running in Future 2'))
        .then((_) => print('and then 1'))
        .then((_) => print('and then 2')); // 上一个事件循环结束后，连续输出三段字符串
    print(123);
  }

  void test2() {
    // f1 比 f2 先执行
    Future(() => print('f1'));
    Future(() => print('f2'));

    // f3 执行后会立刻同步执行 then 3
    Future(() => print('f3')).then((_) => print('then 3'));

    // then 4 会加入微任务队列，尽快执行
    Future(() => null).then((_) => print('then 4'));
  }

  void test3() {
    Future(() => print('f1')); // 声明一个匿名 Future
    Future fx = Future(() => null); // 声明 Future fx，其执行体为 null

    // 声明一个匿名 Future，并注册了两个 then。在第一个 then 回调里启动了一个微任务
    Future(() => print('f2')).then((_) {
      print('f3');
      scheduleMicrotask(() => print('f4'));
    }).then((_) => print('f5'));

    // 声明了一个匿名 Future，并注册了两个 then。第一个 then 是一个 Future
    Future(() => print('f6'))
        .then((_) => Future(() => print('f7')))
        .then((_) => print('f8'));

    // 声明了一个匿名 Future
    Future(() => print('f9'));

    // 往执行体为 null 的 fx 注册了了一个 then
    fx.then((_) => print('f10'));

    // 启动一个微任务
    scheduleMicrotask(() => print('f11'));
    print('f12');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AsyncPage'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // test3();
            final _counter = Provider.of<CounterModel>(context, listen: true);
            _counter.increment;
          },
          child: Text('test'),
        ),
      ),
    );
  }
}
