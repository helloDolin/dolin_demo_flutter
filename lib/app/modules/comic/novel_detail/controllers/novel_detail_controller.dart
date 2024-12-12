import 'package:dolin/app/util/clipboard_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher_string.dart';

class NovelDetailController extends GetxController {
  RxInt count = 0.obs;
  void share(String url, {String content = '内容'}) {
    // ignore: inference_failure_on_function_invocation
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      useSafeArea: true,
      backgroundColor: Get.theme.cardColor,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text('复制链接'),
            onTap: () {
              Get.back<void>();
              ClipboardUtil.setDataToast(url);
            },
          ),
          Visibility(
            visible: content.isNotEmpty,
            child: ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('复制标题与链接'),
              onTap: () {
                Get.back<void>();
                ClipboardUtil.setDataToast('$content\n$url');
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.public),
            title: const Text('浏览器打开'),
            onTap: () {
              Get.back<void>();
              // launchUrlString(url, mode: LaunchMode.externalApplication);
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.share),
          //   title: const Text('系统分享'),
          //   onTap: () {
          //     Get.back<void>();
          //     Share.share(content.isEmpty ? url : '$content\n$url');
          //   },
          // ),
        ],
      ),
    );
  }

  void increment() {
    count.value++;
  }
}
