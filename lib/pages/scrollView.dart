// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../util/number.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScrollViewPage extends StatefulWidget {
  const ScrollViewPage({Key? key}) : super(key: key);

  @override
  State<ScrollViewPage> createState() => _ScrollViewPageState();
}

class _ScrollViewPageState extends State<ScrollViewPage> {
  late ScrollController _controller; // ListView 控制器
  bool _isToTop = false; // 标示目前是否需要启用 "Top" 按钮

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      // 为控制器注册滚动监听方法
      if (_controller.offset > 1000) {
        // 如果 ListView 已经向下滚动了 1000，则启用 Top 按钮
        setState(() {
          _isToTop = true;
        });
      } else if (_controller.offset < 300) {
        // 如果 ListView 向下滚动距离不足 300，则禁用 Top 按钮
        setState(() {
          _isToTop = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); // 销毁控制器
    super.dispose();
  }

  void debugPrintScreenInformation() {
    debugPrint(30.rpx.toString());

    debugPrint('设备宽度:${ScreenUtil().screenWidth}'); //Device width
    debugPrint('设备高度:${ScreenUtil().screenHeight}'); //Device height
    debugPrint('设备的像素密度:${ScreenUtil().pixelRatio}'); //Device pixel density
    debugPrint(
      '底部安全区距离:${ScreenUtil().bottomBarHeight}dp',
    ); //Bottom safe zone distance，suitable for buttons with full screen
    debugPrint(
      '状态栏高度:${ScreenUtil().statusBarHeight}dp',
    ); //Status bar height , Notch will be higher Unit px
    debugPrint('实际宽度的dp与设计稿px的比例:${ScreenUtil().scaleWidth}');
    debugPrint('实际高度的dp与设计稿px的比例:${ScreenUtil().scaleHeight}');
    // debugPrint(
    //   '宽度和字体相对于设计稿放大的比例:${ScreenUtil().scaleWidth * ScreenUtil().pixelRatio}',
    // );
    // debugPrint(
    //   '高度相对于设计稿放大的比例:${ScreenUtil().scaleHeight * ScreenUtil().pixelRatio}',
    // );
    debugPrint('系统的字体缩放比例:${ScreenUtil().textScaleFactor}');

    debugPrint('屏幕宽度的0.5:${0.5.sw}');
    debugPrint('屏幕高度的0.5:${0.5.sh}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ScrollViewPage'),
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () {
                if (_isToTop) {
                  debugPrintScreenInformation();
                  _controller.animateTo(.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease); // 做一个滚动到顶部的动画
                }
                Navigator.pop(context, 'scrollView 回调');
              },
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text('pop'),
              ),
            ),
            Expanded(
                child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      // 注册通知回调
                      if (scrollNotification is ScrollStartNotification) {
                        // 滚动开始
                        debugPrint('Scroll Start');
                      } else if (scrollNotification
                          is ScrollUpdateNotification) {
                        // 滚动位置更新
                        debugPrint('Scroll Update');
                      } else if (scrollNotification is ScrollEndNotification) {
                        // 滚动结束
                        debugPrint('Scroll End');
                      }
                      return true;
                    },
                    child: ListView.separated(
                      controller: _controller, // 初始化传入控制器
                      itemCount: 100, // 列表元素总数
                      separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 1,
                        color: index & 1 == 1 ? Colors.red : Colors.blue,
                      ),
                      itemBuilder: (context, index) =>
                          ListTile(title: Text("Index : $index")), // 列表项构造方法
                    ))),
          ],
        )
        // CustomScrollView(slivers: <Widget>[
        //   SliverAppBar(
        //     //SliverAppBar 作为头图控件
        //     title: const Text('CustomScrollView Demo'), // 标题
        //     floating: true, // 设置悬浮样式
        //     flexibleSpace: Image.network(
        //         'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201411%2F29%2F20141129090448_arR88.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1677671198&t=b61588b033a898f9a67aa65f7b7decd3',
        //         fit: BoxFit.cover), // 设置悬浮头图背景
        //     expandedHeight: 300, // 头图控件高度
        //   ),
        //   SliverList(
        //     // SliverList 作为列表控件
        //     delegate: SliverChildBuilderDelegate(
        //       (context, index) =>
        //           ListTile(title: Text('Item #$index')), // 列表项创建方法
        //       childCount: 100, // 列表元素个数
        //     ),
        //   ),
        // ]),
        );
  }
}
