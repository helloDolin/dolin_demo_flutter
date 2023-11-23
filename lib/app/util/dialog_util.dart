import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DialogUtil {
  /// 提示弹窗
  /// - `content` 内容
  /// - `title` 弹窗标题
  /// - `confirm` 确认按钮内容，留空为确定
  /// - `cancel` 取消按钮内容，留空为取消
  static Future<bool> showAlertDialog(
    String content, {
    String title = '',
    String confirm = '',
    String cancel = '',
    bool selectable = false,
    bool barrierDismissible = true,
    List<Widget>? actions,
  }) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Container(
          constraints: const BoxConstraints(
            maxHeight: 400,
            maxWidth: 500,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: selectable ? SelectableText(content) : Text(content),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(cancel.isEmpty ? '取消' : cancel),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(confirm.isEmpty ? '确定' : confirm),
          ),
          ...?actions,
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
    return result ?? false;
  }

  /// 展示声明弹窗
  static Future<void> showStatement() async {
    final text = await rootBundle.loadString('assets/statement.txt');

    await showAlertDialog(
      text,
      selectable: true,
      title: '免责声明',
      confirm: '已阅读并同意',
      cancel: '退出',
      barrierDismissible: false,
    ).then((value) {
      debugPrint('cur value is ----------- $value');
      if (!value) {
        exit(0);
      }
    });
  }
}
