// ignore: dangling_library_doc_comments
/// @author shaolin
/// @email 366688603@qq.com
/// @create date 2024-01-02 15:29:53
/// @modify date 2024-01-02 15:29:53
/// @desc [剪贴板工具]

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 剪贴板工具
class ClipboardUtil {
  /// 复制内容-无 toast 提示
  static void setData(String data) {
    if (data != '') {
      Clipboard.setData(ClipboardData(text: data));
    }
  }

  // 复制内容-toast 提示复制成功
  static void setDataToast(String data) {
    if (data != '') {
      Clipboard.setData(ClipboardData(text: data));
      showToast('复制成功');
    }
  }

  // 复制内容- 自定义 toast 内容
  static void setDataToastMsg(String data, {String toastMsg = '复制成功'}) {
    if (data != '') {
      Clipboard.setData(ClipboardData(text: data));
      showToast(toastMsg);
    }
  }

  /// 获取内容
  static Future<ClipboardData?> getData() {
    return Clipboard.getData(Clipboard.kTextPlain);
  }

  /// Fluttertoast
  static void showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
    );
  }
}
