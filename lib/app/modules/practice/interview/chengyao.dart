import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model.dart';

class ChengYaoJianKang extends StatefulWidget {
  const ChengYaoJianKang({super.key});

  @override
  State<ChengYaoJianKang> createState() => _ChengYaoJianKangState();
}

class _ChengYaoJianKangState extends State<ChengYaoJianKang> {
  final _res = <String>[];

  Future<ModuleModel> getModules() async {
    String jsonData = await rootBundle.loadString("assets/json/modules.json");
    final jsonresult = json.decode(jsonData);
    return ModuleModel.fromJson(jsonresult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('面试-乘耀健康'),
      ),
      body: Column(
        children: [
          _tagTest(),
          SizedBox(
            height: 500,
            child: DiagonalWidget(
              children: [
                const FlutterLogo(
                  size: 100,
                ),
                const Text('123123123'),
                Container(
                  width: 100,
                  height: 200,
                  color: Colors.red,
                ),
                const FlutterLogo(
                  size: 30,
                ),
                Container(
                  width: 10,
                  height: 100,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: TextButton(
          onPressed: () async {
            ModuleModel obj = await getModules();
            for (var item in obj.modules!) {
              loadModules(item);
            }
            debugPrint(_res.toString());
          },
          child: const Text(
            '点击测试',
          )),
    );
  }

  // 递归
  // 这个算法有问题
  void loadModules(Module module) {
    if ((module.dependencies ?? []).isNotEmpty) {
      if (!_res.contains(module.name)) {
        _res.add(module.name!);
      }
    } else {
      for (var item in module.dependencies!) {
        loadModules(Module()..name = item);
      }
    }
  }

  Wrap _tagTest() {
    return const Wrap(
      runSpacing: 10,
      spacing: 10,
      children: [
        Tag(
          content: '阿斯顿发生大法师大法师阿斯顿发生大法师大法师阿斯顿发生大法师大法师阿斯顿发生大法师大法师',
        ),
        Tag(
          content: 'abc',
        ),
        Tag(
          content: '123231',
        ),
      ],
    );
  }
}

class DiagonalWidget extends StatelessWidget {
  const DiagonalWidget({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: MyDelegate(),
      children: [
        for (int i = 0; i < children.length; i++)
          LayoutId(id: i, child: children[i])
      ],
    );
  }
}

class MyDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    Offset offset = Offset.zero;
    for (int i = 0;; i++) {
      if (hasChild(i)) {
        final childSize = layoutChild(i, BoxConstraints.loose(size));
        positionChild(i, offset);
        offset += Offset(childSize.width, childSize.height);
      } else {
        break;
      }
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}

class Tag extends StatelessWidget {
  const Tag({super.key, required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 3),
          const Icon(Icons.circle),
          const SizedBox(width: 3),
          Flexible(
            // fit: FlexFit.loose,
            child: Text(
              content,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 3),
          const Icon(Icons.arrow_forward),
          const SizedBox(width: 3),
        ],
      ),
    );
  }
}
