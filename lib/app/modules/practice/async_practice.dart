// ignore_for_file: file_names

import 'dart:async';

import 'package:dolin/app/common_widgets/code/code_widget.dart';
import 'package:dolin/app/common_widgets/code/highlighter_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class AsyncPage extends StatefulWidget {
  const AsyncPage({Key? key}) : super(key: key);

  @override
  State<AsyncPage> createState() => _AsyncPageState();
}

class _AsyncPageState extends State<AsyncPage> {
  String _debugText = '';

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
    Future(() {
      debugPrint('f1');
      _debugText += 'f1\n';
    }); // 声明一个匿名 Future
    Future fx = Future(() => null); // 声明 Future fx，其执行体为 null

    // 声明一个匿名 Future，并注册了两个 then。在第一个 then 回调里启动了一个微任务
    Future(() {
      debugPrint('f2');
      _debugText += 'f2\n';
    }).then((_) {
      debugPrint('f3');
      _debugText += 'f3\n';

      scheduleMicrotask(() {
        debugPrint('f4');
        _debugText += 'f4\n';
      });
    }).then((_) {
      debugPrint('f5');
      _debugText += 'f5\n';
    });

    // 声明了一个匿名 Future，并注册了两个 then。第一个 then 是一个 Future
    Future(() {
      debugPrint('f6');
      _debugText += 'f6\n';
    })
        .then((_) => Future(() {
              debugPrint('f7');
              _debugText += 'f7\n';
            }))
        .then((_) {
      debugPrint('f8');
      _debugText += 'f8\n';
    });

    // 声明了一个匿名 Future
    Future(() {
      debugPrint('f9');
      _debugText += 'f9\n';
    });

    // 往执行体为 null 的 fx 注册了了一个 then
    fx.then((_) {
      debugPrint('f10');
      _debugText += 'f10\n';
    });

    // 启动一个微任务
    scheduleMicrotask(() {
      debugPrint('f11');
      _debugText += 'f11\n';
    });
    debugPrint('f12');
    _debugText += 'f12\n';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AsyncPage'),
      ),
      body: ListView(
        children: [
          CodeWidget(
            code: '''
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
''',
            style: HighlighterStyle.fromColors(HighlighterStyle.gitHub),
          ),
          const SizedBox(height: 20),
          Text(
            '打印结果：\n$_debugText',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF000000),
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          _debugText = '';
          test3();
          SmartDialog.showLoading();
          await Future.delayed(const Duration(seconds: 1));
          if (mounted) {
            SmartDialog.dismiss();
            setState(() {});
          }
        },
        child: const Text(
          '点击显示打印结果',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF000000),
          ),
        ),
      ),
    );
  }
}
