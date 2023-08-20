import 'package:dolin/app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger_flutter_plus/logger_flutter_plus.dart';

class LogView extends StatefulWidget {
  const LogView({super.key});

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  bool _canpop = true;

  Future<String> task1() async {
    await Future.delayed(const Duration(seconds: 2));
    print('task1');
    return 'task1';
  }

  Future<String> task2() async {
    await Future.delayed(const Duration(seconds: 1));
    print('task2');
    return 'task2';
  }

  @override
  Widget build(BuildContext context) {
    // 正确使用 WillPopScope 的姿势
    // 1. 返回 null 表示不拦截
    // 2. 返回 Future 表示拦截，并返回一个 Future，Future 返回 true 表示拦截，返回 false 表示不拦截
    // 直接 return true 或 false 会阻止手势
    return WillPopScope(
      onWillPop: _canpop
          ? null
          : () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (cxt) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(cxt);
                        },
                        child: const Text('取消'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(cxt);
                          Navigator.pop(context);
                        },
                        child: const Text('确定'),
                      )
                    ],
                  ),
                ),
              );
              return false;
            },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('摇晃手机返回'),
          actions: [
            TextButton(
                child: const Text('类iOS异步group'),
                onPressed: () {
                  // print('执行 group');
                  // await task1();
                  // await task2();
                  // print('执行 group 结束');

                  Future.wait([task1(), task2()])
                      .then((value) {
                        // Future 返回结果
                        print(value);
                      })
                      .whenComplete(() => print('执行 group 结束'))
                      .catchError((err) {
                        print(err);
                      });
                })
          ],
        ),
        body: ShakeDetectorWidget(
          shakeDetector: DefaultShakeDetector(onPhoneShake: () {
            Get.back();
          }),
          child: LogConsoleWidget(
            logConsoleManager: StorageService.instance.logConsoleManager,
            theme: LogConsoleTheme.byTheme(Theme.of(context)),
          ),
        ),
        floatingActionButton: ElevatedButton(
          child: Text(_canpop ? '可以返回' : '不可以返回'),
          onPressed: () async {
            setState(() {
              _canpop = !_canpop;
            });
          },
        ),
      ),
    );
  }
}
