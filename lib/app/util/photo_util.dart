import 'dart:io';

import 'package:dolin/app/util/toast_util.dart';
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
Future<void> saveImageDetktop(String url) async {
  // 代码有问题暂时注释掉
  // final response =
  //     await Dio().get(url, options: Options(responseType: ResponseType.bytes));
  // final Uint8List uint8List = Uint8List.fromList(response.data as List<int>);

  // final FileSaveLocation? location = await getSaveLocation(suggestedName: url);
  // final String path = location?.path ?? '';
  // if (path.isEmpty) {
  //   return;
  // }
  // final XFile file = XFile.fromData(uint8List, name: url);
  // await file.saveTo(path);
}
