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

  // async*是“异步生成器函数”，它必须始终返回Stream<T>，并使用yield将值add到流中。不能在async*函数中使用return关键字
  // sync*是一个dart语法关键字。它标注在函数{ 之前，其方法必须返回一个 Iterable<T>对象 👿 的码为\u{1f47f}。下面是使用sync*生成后10个emoji迭代(Iterable)对象的方法
  Iterable<String> getEmoji(int count) sync* {
    Runes first = Runes('\u{1f47f}');
    for (int i = 0; i < count; i++) {
      yield String.fromCharCodes(first.map((e) => e + i));
    }
  }

  // yield*后面的表达式是一个Iterable<T>对象
  Iterable<String> getEmojiWithTime(int count) sync* {
    yield* getEmoji(count)
        .map((e) => '$e -- ${DateTime.now().toIso8601String()}');
  }

  // async*是一个dart语法关键字。它标注在函数{ 之前，其方法必须返回一个 Stream<T>对象
  // 下面fetchEmojis被async*标注，所以返回的必然是Stream对象
  // 注意被async*标注的函数，可以在其内部使用yield、yield*、await关键字
  Stream<String> fetchEmojis(int count) async* {
    for (int i = 0; i < count; i++) {
      yield await fetchEmoji(i);
    }
  }

  Future<String> fetchEmoji(int count) async {
    Runes first = Runes('\u{1f47f}');
    print('加载开始--${DateTime.now().toIso8601String()}');
    await Future.delayed(Duration(seconds: 2)); //模拟耗时
    print('加载结束--${DateTime.now().toIso8601String()}');
    return String.fromCharCodes(first.map((e) => e + count));
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
          // getEmoji(10).forEach(print);
          // getEmojiWithTime(10).forEach(print);
          fetchEmojis(10).listen(print);

          // test3();
          // counter.increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
