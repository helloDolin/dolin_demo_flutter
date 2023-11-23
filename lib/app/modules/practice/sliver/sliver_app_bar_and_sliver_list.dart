import 'package:flutter/material.dart';

class SliverPractice extends StatelessWidget {
  const SliverPractice({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: const Text('SliverList'),
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              'https://img.zcool.cn/community/01014259f069b7a801216a4b278f97.jpg@1280w_1l_2o_100sh.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                height: 80,
                color: Colors.primaries[index % 11],
              );
            },
            childCount: 30,
          ),
        ),
      ],
    );
  }
}
