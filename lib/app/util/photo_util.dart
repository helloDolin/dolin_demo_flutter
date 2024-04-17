import 'dart:io';

import 'package:dolin/app/util/toast_util.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

/// 检查相册权限
Future<bool> checkPhotoPermission() async {
  try {
    var status = await Permission.photos.status;
    if (status == PermissionStatus.granted) {
      return true;
    }
    status = await Permission.photos.request();
    if (status.isGranted) {
      return true;
    } else {
      showToast('请授予相册权限');
      return false;
    }
  } catch (e) {
    return false;
  }
}

/// 保存图片-移动平台
Future<void> saveNetImage(String url) async {
  if (url.isEmpty) {
    return;
  }
  if (Platform.isIOS && !await checkPhotoPermission()) {
    return;
  }
  final bool? res = await GallerySaver.saveImage(url);
  if (res ?? false) {
    showToast('保存成功');
  }
}

/// 保存图片-桌面平台
Future<void> saveImageDetktop(String fileName, Uint8List list) async {
  final String? path = await getSavePath(suggestedName: fileName);
  if (path == null) {
    return;
  }
  final XFile file = XFile.fromData(list, name: fileName);
  await file.saveTo(path);
}
