import 'package:dolin/app/modules/comic/novel_detail/controllers/novel_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NovelDetailView extends StatelessWidget {
  NovelDetailView({
    required this.id,
    required this.title,
    super.key,
  }) : controller = Get.put(
          NovelDetailController(),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        );
  final int id;
  final String title;
  final NovelDetailController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.share('https://www.baidu.com');
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => Text(controller.count.value.toString())),
            ExpansionTile(
              title: const Text('第一卷（共20章）'),
              leading: SizedBox(
                width: 40,
                child: Checkbox(
                  value: true,
                  onChanged: (e) {
                    // if (e!) {
                    //   volume.addAll(
                    //     item.chapters
                    //         .where((x) => !NovelDownloadService.instance.downloadIds
                    //             .contains(
                    //                 "${novelId}_${x.volumeId}_${x.chapterId}"))
                    //         .map((e) => e.chapterId),
                    //   );
                    // } else {
                    //   volume.clear();
                    // }
                  },
                ),
              ),
              tilePadding: const EdgeInsets.all(10),
              children: [
                ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(index.toString()),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                  ),
                  itemCount: 100,
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: () {
                  Get.to<NovelDetailView>(
                    () => NovelDetailView(id: 123, title: '123'),
                    preventDuplicates: false,
                  );
                },
                icon: const Icon(
                  Icons.details,
                ),
                label: const Text('自己跳自己'),
              ),
            ),
            Expanded(
              child: TextButton.icon(
                onPressed: controller.increment,
                icon: const Icon(Icons.add),
                label: const Text('count + 1'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
