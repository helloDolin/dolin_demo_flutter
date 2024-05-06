import 'package:dolin/app/modules/practice/sliver/juejin/search_bar.dart'
    as search_bar;
import 'package:dolin/app/modules/practice/sliver/juejin/sliver_header/sliver_pinned_header.dart';
import 'package:dolin/app/modules/practice/sliver/juejin/sliver_header/sliver_snap_header.dart';
import 'package:flutter/material.dart';

class JuejinHomePage extends StatefulWidget {
  const JuejinHomePage({super.key});

  @override
  State<JuejinHomePage> createState() => _JuejinHomePageState();
}

class _JuejinHomePageState extends State<JuejinHomePage>
    with SingleTickerProviderStateMixin {
  final List<String> _tabs = <String>['关注', '推荐', '热榜', '精选'];

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: _tabs.length, vsync: this);
  }

  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    return [
      const SliverSnapHeader(
        child: search_bar.SearchBar(),
      ),
      // 占位，保证切换 tab 时，不受其他滑动的影响
      SliverOverlapAbsorber(
        sliver: SliverPinnedHeader(
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            controller: tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: _tabs.map((String name) => Tab(text: name)).toList(),
          ),
        ),
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
          context,
        ), // 注意传 handle
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.paddingOf(context).top,
          ),
          Expanded(
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: _buildHeader,
              body: TabBarView(
                controller: tabController,
                children: _tabs.map(buildScrollPage).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScrollPage(String name) {
    return Builder(
      builder: (BuildContext context) => CustomScrollView(
        key: PageStorageKey<String>(name), // 保持滑动位置
        slivers: <Widget>[
          // 占位
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverFixedExtentList(
              itemExtent: 48,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
                childCount: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
