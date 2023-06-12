import 'dart:math' as math;

import 'package:flutter/material.dart';

class LayoutPractice extends StatefulWidget {
  const LayoutPractice({super.key});

  @override
  State<LayoutPractice> createState() => _LayoutPracticeState();
}

class _LayoutPracticeState extends State<LayoutPractice> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('布局练习'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _layoutList(),
            ],
          ),
        ),
      ),
    );
  }

  ExpansionTile _layoutList() {
    return ExpansionTile(
      backgroundColor: Colors.blue,
      trailing: Transform.rotate(
        angle: _isExpanded ? 0 : math.pi, // 旋转90度
        child: const Icon(
          Icons.arrow_upward,
          color: Colors.grey,
        ),
      ),
      title: const Text(
        '点我展开',
        style: TextStyle(color: Colors.red),
      ),
      onExpansionChanged: (isExpanded) {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      initiallyExpanded: true,
      children: <Widget>[
        const Text('''核心思想：
向下传递约束，向上传递尺寸，父级决定位置
'''),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 50,
            maxWidth: 100,
            minHeight: 50,
            maxHeight: 100,
          ),
          child: Container(
            width: 1000,
            height: 1000,
            color: Colors.red,
          ),
        ),
        ConstrainedBox(
          // Creates box constraints that is respected only by the given size
          constraints: BoxConstraints.tight(
            const Size(100, 100),
          ),
          child: Container(
            width: 10,
            height: 10,
            color: Colors.green,
          ),
        ),
        ConstrainedBox(
          // Creates box constraints that forbid sizes larger than the given size.
          constraints: BoxConstraints.loose(
            const Size(100, 100),
          ),
          child: Container(
            width: 1000,
            height: 1000,
            color: Colors.amber,
          ),
        ),
        UnconstrainedBox(
          child: Container(
            width: 1000,
            height: 100,
            color: Colors.blue,
          ),
        ),
        LimitedBox(
          child: Container(
            width: 1000,
            height: 1000,
            color: Colors.yellow,
          ),
        ),
        const FittedBox(
          child: Text('超过 width 自动缩小,使用场景：需要全部显示，但又要求不换行'),
        ),
      ],
      //初始状态为闭合状态(默认状态)
    );
  }
}
