import 'package:dolin_demo_flutter/app/data/douban250.dart';
import 'package:dolin_demo_flutter/app/service/httpsClient.dart';
import 'package:dolin_demo_flutter/app/util/randomColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TabListView extends StatefulWidget {
  const TabListView({super.key, required this.source});
  final String source;

  @override
  State<TabListView> createState() => _TabListViewState();
}

class _TabListViewState extends State<TabListView>
    with AutomaticKeepAliveClientMixin {
  late List<Douban250> _listData;
  late RefreshController _refreshController;
  late ScrollController _scrollController;
  bool _isShowUpIcon = false;

  int skip = 0;
  final pageSize = 5;

  @override
  void initState() {
    _listData = [];
    _refreshController = RefreshController(initialRefresh: true);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      print(
          'scrollController.position.pixels:${_scrollController.position.pixels}');
      if (_scrollController.position.pixels > 200 &&
          _isShowUpIcon == false &&
          mounted) {
        setState(() {
          _isShowUpIcon = true;
        });
      }
      if (_scrollController.position.pixels < 200 &&
          _isShowUpIcon == true &&
          mounted) {
        setState(() {
          _isShowUpIcon = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onRefresh() {
    skip = 0;
    _listData = [];
    reqDouban250(isRefresh: true);
    _refreshController.refreshCompleted();
  }

  void _onLoading() {
    skip += pageSize;
    reqDouban250(isRefresh: false);
    _refreshController.loadComplete();
  }

  void reqDouban250({bool isRefresh = false}) async {
    String apiUrl =
        'https://api.wmdb.tv/api/v1/top?type=${widget.source}&skip=$skip&limit=$pageSize&lang=Cn';
    print(apiUrl);
    final res = await HttpsClient().get(apiUrl);
    if (res != null) {
      List<Douban250> douban250List = douban250FromList(res.data);
      if (isRefresh) {
        _listData = douban250List;
      } else {
        _listData.addAll(douban250List);
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropHeader(),
          footer: CustomFooter(
            builder: (context, mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = const Text("上拉加载");
              } else if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = const Text("加载失败！点击重试！");
              } else if (mode == LoadStatus.canLoading) {
                body = const Text("松手,加载更多!");
              } else {
                body = const Text("没有更多数据了!");
              }
              return SizedBox(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.separated(
            controller: _scrollController,
            separatorBuilder: (context, index) => Container(
              height: 10,
              color: getRandomColor().withOpacity(0.3),
            ),
            itemBuilder: (c, i) {
              return Item(model: _listData[i], index: i);
            },
            itemCount: _listData.length,
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: _isShowUpIcon
                ? ElevatedButton(
                    onPressed: () {
                      _scrollController.jumpTo(0);
                    },
                    child: const Icon(Icons.arrow_upward_outlined))
                : const SizedBox.shrink()),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Item extends StatelessWidget {
  const Item({super.key, required this.model, required this.index});
  final Douban250 model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: model.shareImage,
                  fit: BoxFit.fitWidth,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      const SizedBox(
                    child: Text('图片加载失败'),
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Text('片名：${model.originalName ?? ''}')),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Text('排名：${index + 1}')),
        ],
      ),
    );
  }
}
