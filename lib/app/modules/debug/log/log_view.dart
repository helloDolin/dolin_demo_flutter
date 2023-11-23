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
              await showDialog<void>(
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
        ),
        body: ShakeDetectorWidget(
          shakeDetector: DefaultShakeDetector(
            onPhoneShake: Get.back<void>,
          ),
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
