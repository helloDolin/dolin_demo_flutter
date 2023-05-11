import 'package:dolin_demo_flutter/app/common_widgets/keepAliveWrapper.dart';
import 'package:dolin_demo_flutter/app/common_widgets/page_list/dl_page_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/comic/recommend_model.dart';
import 'list_controller.dart';

class ListView extends StatelessWidget {
  final ListController controller;

  ListView({Key? key})
      : controller = Get.put(ListController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: DLPageListView(
        pageController: controller,
        firstRefresh: true,
        loadMore: false,
        showPageLoadding: true,
        itemBuilder: (context, index) {
          final RecommendModel item = controller.list[index];
          return Text(item.title ?? '');
        },
      ),
    );
  }
}
