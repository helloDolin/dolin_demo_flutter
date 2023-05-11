import 'package:dolin_demo_flutter/app/apis/home/home.dart';
import 'package:dolin_demo_flutter/app/common_widgets/gallery/index.dart';
import 'package:dolin_demo_flutter/app/constants/constants.dart';
import 'package:dolin_demo_flutter/app/data/home/douban250.dart';
import 'package:dolin_demo_flutter/app/util/random_color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      // print(
      //     'scrollController.position.pixels:${_scrollController.position.pixels}');
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
    reqData(isRefresh: true).then((_) {
      _refreshController.refreshCompleted();
    }).catchError((_) {
      _refreshController.refreshFailed();
    });
  }

  void _onLoading() {
    if (_listData.length % pageSize == 0) {
      reqData(isRefresh: false).then((_) {
        _refreshController.loadComplete();
      }).catchError((_) {
        _refreshController.loadFailed();
      });
    } else {
      _refreshController.loadNoData();
    }
  }

  Future<void> reqData({bool isRefresh = false}) async {
    if (isRefresh) {
      skip = 0;
      _listData.clear();
    } else {
      skip += pageSize;
    }

    final res = await HomeAPI.movieList(widget.source, pageSize, skip);

    if (mounted) {
      setState(() {
        _listData.addAll(res);
      });
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
          // header: const WaterDropHeader(),
          // footer: CustomFooter(
          //   builder: (context, mode) {
          //     Widget body;
          //     if (mode == LoadStatus.idle) {
          //       body = const Text("上拉加载");
          //     } else if (mode == LoadStatus.loading) {
          //       body = const CupertinoActivityIndicator();
          //     } else if (mode == LoadStatus.failed) {
          //       body = const Text("加载失败！点击重试！");
          //     } else if (mode == LoadStatus.canLoading) {
          //       body = const Text("松手,加载更多!");
          //     } else {
          //       body = const Text("没有更多数据了!");
          //     }
          //     return SizedBox(
          //       height: 55.0,
          //       child: Center(child: body),
          //     );
          //   },
          // ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.separated(
            // ListView 不会销毁那些在屏幕可视范围之外的那些 item，如果 item 使用了高分辨率的图片，那么它将会消耗非常多的内存
            // 通过将这两个选项置为 false 来禁用它们，这样不可见的子元素就会被自动处理和 GC
            addRepaintBoundaries: false,
            addAutomaticKeepAlives: false,
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
    return InkWell(
      onTap: () {
        openGallery(context, 0, [model.shareImage]);
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenWidth * 880 / 540, // 图片尺寸：540 * 880
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FadeInImage.assetNetwork(
                    placeholder: AppAssets.placeholderPng,
                    placeholderFit: BoxFit.cover,
                    image: model.shareImage,
                    fit: BoxFit.cover,
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
      ),
    );
  }
}
