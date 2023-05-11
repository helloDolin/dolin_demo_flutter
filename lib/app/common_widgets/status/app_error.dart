import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../util/clipboard_util.dart';

class AppErrorWidget extends StatelessWidget {
  final Function()? onRefresh;
  final String errorMsg;
  final Error? error;
  const AppErrorWidget(
      {this.errorMsg = "", this.onRefresh, this.error, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          onRefresh?.call();
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset(
                'assets/lotties/error.json',
                width: 260,
                repeat: false,
              ),
              Text(
                "$errorMsg\r\n点击刷新",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Visibility(
                visible: error != null,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      textStyle: Get.textTheme.bodySmall,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      ClipboardUtil.setDataToastMsg(
                        '$errorMsg\n${error?.stackTrace?.toString()}',
                      );
                    },
                    child: const Text("复制详细信息"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
