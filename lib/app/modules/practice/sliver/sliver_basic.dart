import 'dart:math';

import 'package:flutter/material.dart';

class SliverBasic extends StatelessWidget {
  const SliverBasic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('SliverBasic'),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // title: Text('SliverBasic'),
            floating: true, // 下拉时出现 appbar
            snap: true, // 下拉时出现全貌 appbar
            // pinned: true, // 上拉时不消失
            expandedHeight:
                150, // 一般设置了 expandedHeight，stretch 需要同时设置 stretchModes
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://img.zcool.cn/community/01014259f069b7a801216a4b278f97.jpg@1280w_1l_2o_100sh.jpg',
                fit: BoxFit.cover,
              ),
              title: const Text(
                'SliverBasic',
                style: TextStyle(color: Colors.black),
              ),
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
                StretchMode.fadeTitle
              ],
            ),
          ),
          // // 当前视窗剩余
          const SliverFillRemaining(
            hasScrollBody: false, // 滚动区域不需要改动
            child: Align(
              // ignore: use_named_constants
              alignment: Alignment(0, 1),
              child: CircularProgressIndicator(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 100, child: Placeholder()),
          ),
          SliverPrototypeExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const Text('data'),
              childCount: 5,
            ),
            prototypeItem: const SizedBox(
              height: 30,
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50,
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                color: Colors.primaries[index % Colors.primaries.length][400],
              ),
              childCount: 5,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                color: Colors.primaries[index % Colors.primaries.length][300],
                height: 40,
              ),
              childCount: 5,
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                color: Colors.primaries[index % Colors.primaries.length][200],
                height: 40,
              ),
              childCount: 50,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
          ),
          // 相当于 pageView
          SliverFillViewport(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ColoredBox(
                color: Colors.primaries[Random().nextInt(18)],
                child: const Center(
                  child: FlutterLogo(),
                ),
              ),
              childCount: 3,
            ),
          ),
        ],
      ),
    );
  }
}
