import 'package:flutter/material.dart';

import 'widgets/corner_mark.dart';
import 'widgets/countdown_button.dart';
import 'widgets/diagonal.dart';
import 'widgets/gallery_view.dart';
import 'widgets/hollow_text.dart';
import 'widgets/wartermark.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('王叔不秃挑战')),
      body: _buildBody(),
    );
  }

  /// ListView 实现 GridView
  LayoutBuilder _buildGrid() {
    return LayoutBuilder(builder: (context, cons) {
      const int itemCount = 11;
      final int rowCount = (11 / 2).ceil();
      const int perRow = 3;
      return ListView.builder(
        itemCount: rowCount,
        itemBuilder: (context, index) {
          return Row(
            children: [
              for (int i = 0; i < perRow; i++)
                if (index * perRow + i < itemCount)
                  SizedBox(
                    width: cons.maxWidth / perRow,
                    child: const Item(),
                  ),
            ],
          );
        },
      );
    });
  }

  Center _buildBody() {
    return Center(
      child: OrientationBuilder(
        builder: (context, orientation) {
          return SingleChildScrollView(
            child: Flex(
              direction: orientation == Orientation.portrait
                  ? Axis.vertical
                  : Axis.horizontal,
              children: [
                // Column 里边套 ListView，ListView 高度随着 Item 的变化而变化
                // 使用 Stack 的特性，Stack 大小由子 View 决定，如果子 View 有无位置组件，那么 Stack 大小为无位置组件确定
                // 如下 Item 确认其高度，SizedBox 确认其宽度
                Stack(
                  children: [
                    // 不参与事件响应
                    // Opacity 为 0 只参与布局，不参与渲染与合成
                    const IgnorePointer(
                        child: Opacity(
                      opacity: 0.0,
                      child: Item(),
                    )),
                    const SizedBox(
                      width: double.infinity,
                    ),
                    Positioned.fill(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          return const Item();
                        },
                      ),
                    )
                  ],
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: _buildGalleryView(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  spacing: 15,
                  children: const [
                    CountdownButton(
                      width: 100,
                      height: 100,
                      duration: Duration(seconds: 5),
                      radius: 50,
                    ),
                    CountdownButton(
                      width: 100,
                      height: 100,
                      duration: Duration(seconds: 5),
                      radius: 25,
                    ),
                    CountdownButton(
                      width: 100,
                      height: 100,
                      duration: Duration(seconds: 5),
                      radius: 0,
                    ),
                  ],
                ),
                const HollowText(
                  text: '你好',
                  color: Colors.red,
                  fontSize: 50,
                  thickness: 3,
                  hollowColor: Colors.white,
                ),
                SizedBox(
                  height: 100,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CornerMark(
                          cornerMarkPosition: CornerMarkPosition.topLeft,
                          markBgColor: Colors.red[200]!,
                          markTitleColor: Colors.white,
                          markTitle: '哈哈哈',
                          markTitleSize: 12,
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.orange[800],
                          ),
                        ),
                        CornerMark(
                          markBgColor: Colors.red[200]!,
                          markTitleColor: Colors.white,
                          markTitle: '哈哈哈',
                          markTitleSize: 12,
                          cornerMarkPosition: CornerMarkPosition.topRight,
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.orange[600],
                          ),
                        ),
                        CornerMark(
                          cornerMarkPosition: CornerMarkPosition.bottomLeft,
                          markBgColor: Colors.red[200]!,
                          markTitleColor: Colors.white,
                          markTitle: '哈哈哈',
                          markTitleSize: 12,
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.orange[400],
                          ),
                        ),
                        CornerMark(
                          cornerMarkPosition: CornerMarkPosition.bottomRight,
                          markBgColor: Colors.red[200]!,
                          markTitleColor: Colors.white,
                          markTitle: '哈哈哈',
                          markTitleSize: 12,
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.orange[200],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 300,
                  height: 200,
                  child: Watermark(
                    watermarkContent: '绝密',
                    child: FlutterLogo(
                      style: FlutterLogoStyle.horizontal,
                    ),
                  ),
                ),
                Container(
                  color: Colors.blue[100],
                  child: ClipRRect(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Diagonal(
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
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  GalleryView _buildGalleryView() {
    return GalleryView(
      itemCount: 101,
      maxCrossAxisCount: 10,
      builder: (BuildContext context, int index) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(child: Text(index.toString())),
        );
      },
    );
  }
}

class Item extends StatelessWidget {
  const Item({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: const [
          Text(
            'hello',
            style: TextStyle(fontSize: 12),
          ),
          Text(
            'world',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
