import 'package:dolin_demo_flutter/app/util/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PiecesOfKnowledge extends StatefulWidget {
  const PiecesOfKnowledge({super.key});

  @override
  State<PiecesOfKnowledge> createState() => _PiecesOfKnowledgeState();
}

class _PiecesOfKnowledgeState extends State<PiecesOfKnowledge> {
  final textStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
    fontSize: 14,
    height: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('零碎知识点'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: ScreenAdapter.width(375),
          child: DefaultTextStyle.merge(
              style: textStyle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('identical(a, b),判断两个对象是否为同一对象判断两个对象是否为同一对象'),
                  SizedBox(height: ScreenAdapter.height(10)),
                  const Text('SPU:stock keeping unit,库存量单位，标准化产品单元'),
                  SizedBox(height: ScreenAdapter.height(10)),
                  const Text('SKU:standard product unit,标准化产品单元'),
                  SizedBox(height: ScreenAdapter.height(10)),
                  const Text('GetBottomSheet 更新数据需要使用 GetBuilder'),
                  SizedBox(height: ScreenAdapter.height(10)),
                  const Text(
                      'ListView 里边嵌套 GridView，GridView 的 shrikWrap 要设置为 true，否则需要手动设置其高度'),
                  VisibilityDetector(
                    key: const Key('my-widget-key'),
                    onVisibilityChanged: (visibilityInfo) {
                      var visiblePercentage =
                          visibilityInfo.visibleFraction * 100;
                      debugPrint(
                          'Widget ${visibilityInfo.key} is $visiblePercentage% visible');
                    },
                    child: Container(
                      color: Colors.amberAccent,
                      height: ScreenAdapter.height(1000),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
