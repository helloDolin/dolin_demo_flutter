# charming
* GetX 快速进入进出页面 Controller 没有释放解决：使用 statefull 在 dispose 时 手动释放
```dart
late LoginController controller;

@override
void initState() {
  super.initState();
  controller = Get.put(LoginController());
}

@override
void dispose() {
  Get.delete<LoginController>();
  super.dispose();
}
```
* 藏品动画效果
```dart
AnimatedBuilder _buildTestAnimation() {
    return AnimatedBuilder(
      animation: controller.ac,
      builder: (context, child) {
        // print(controller.ac.value);
        return Transform(
          alignment: Alignment.center,
          // angle: controller.ac.value * 0.2, // 调整振幅
          // transform: Matrix4.identity()
          //   // ..setEntry(3, 2, 0.01) // 设置投影参数，实现立体效果
          //   ..rotateY(0.1 * pi * controller.ac.value), // 绕y轴旋转
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0005) // 设置投影参数，实现立体效果,最后一个值越大立体感越强
            ..rotateY(pi / 8 * sin(2 * pi * controller.ac.value)), // 旋转 25 度
          child: Image.asset(
            'assets/images/bitcoin_bull.jpg', // 替换为你的图片路径
            width: 629,
            height: 360,
          ),
        );
      },
    );
  }
```
* 画全屏 UI 时，需要需要先规划好区域（抽签结果页，登录页，底部按钮需要 Spacer() 撑开）
* 安卓 GridView 配合 pull_to_refresh_flutter3，给 padding 的话，上拉加载更多显示有问题
* 安卓底部没有完全展示修改
```dart
SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge)
systemNavigationBarColor: systemNavigationBarColor,
systemNavigationBarDividerColor: systemNavigationBarDividerColor,
```
* 安卓的 .9 图，到 Flutter 这边为 centerSlice
* TabBar 和 TabBarView 不是非要成对出现
* 自定义 TabBar 的 indicator
```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TriangleTabIndicator extends Decoration {
  final Color color;

  const TriangleTabIndicator({required this.color});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TrianglePainter(color);
  }
}

class _TrianglePainter extends BoxPainter {
  final Paint _paint;

  _TrianglePainter(Color color) : _paint = Paint()..color = color;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final double triangleSize = 12.w;
    // 三角形起点坐标
    final double startX = configuration.size!.width + rect.left;
    final double startY = configuration.size!.height - 12.w;
    final Path path = Path()
      ..moveTo(startX, startY)
      ..lineTo(startX - triangleSize, startY)
      ..lineTo(startX, startY - triangleSize)
      ..close();
    // canvas.drawRect(rect, Paint()..color = Colors.blue);
    canvas.drawPath(path, _paint);
  }
}
```
* 自定义 TabBarView 的 physics
```dart
TabBarView(
  physics: const CustomTabBarViewScrollPhysics(),
  controller: controller.tabController,
  children: const [
    KeepAliveWrapper(child: TabPropView()),
    KeepAliveWrapper(child: TabOtherView()),
    KeepAliveWrapper(child: TabBoxView()),
  ],
)

class CustomTabBarViewScrollPhysics extends ScrollPhysics {
  const CustomTabBarViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomTabBarViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomTabBarViewScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 50,
        stiffness: 100,
        damping: 0.8,
      );
}
```



# factory 关键字
在Dart语言中，factory关键字用于创建一个工厂构造函数。工厂构造函数与普通构造函数的区别在于，它们可以返回一个已经存在的实例，或者返回一个子类的实例，而不必每次都创建新的实例

使用场景如下：

1. 单例模式：通过工厂构造函数返回相同的实例，以确保在应用程序中只有一个实例存在。
2. 缓存实例：在工厂构造函数中检查是否已经存在相同属性的实例，如果存在则返回该实例，否则创建新的实例并缓存起来。
3. 返回子类实例：根据一些条件在工厂构造函数中决定返回哪个子类的实例。

# newbie_draw
* 枚举和 model 配合
```dart
import 'dart:ui';

/// 活动类型
enum ActivityType {
  /// 活动已结束
  over(
    3,
    '活动已结束',
    'images/newbie_draw/btn_disable_bg.png',
    Color(0xFFF2D8A9),
  ),

  /// 活动未开始
  notBegin(
    1,
    '活动未开始',
    'images/newbie_draw/btn_disable_bg.png',
    Color(0xFFF2D8A9),
  ),

  /// 进行中
  ing(
    2,
    '拉人获取更多抽签码',
    'images/newbie_draw/btn_enable_bg.png',
    Color(0xFF502F2F),
  ),

  /// 异常
  unknown(
    -1,
    '--',
    'images/newbie_draw/btn_disable_bg.png',
    null,
  );

  final int value;
  final String name;
  final String btnImgUrl;
  final Color? btnTitleColor;
  const ActivityType(this.value, this.name, this.btnImgUrl, this.btnTitleColor);

  static ActivityType fromValue(int value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => ActivityType.unknown,
    );
  }
}

/// null 时为 unknow，其他读后端
factory ActivityListItem.fromJson(Map<String, dynamic> json) =>
      ActivityListItem(
        activityId: json['activity_id'],
        price: json["price"] ?? 0,
        productUrl: json["product_url"],
        productName: json["product_name"],
        lotteryInfo: json["lottery_info"],
        leftTime: json["left_time"],
        activityType: json['status'] == null
            ? ActivityType.unknown
            : ActivityType.fromValue(json['status']),
        codeList: json["code_list"] == null
            ? []
            : List<CodeInfo>.from(
                json["code_list"]!.map((x) => CodeInfo.fromJson(x))),
        copy: json["copy"],
      );
```
* Future then 和 await 不要同时使用
* json list 解析加上 try catch，防止后端异常数据格式或其他返回
```dart
class Request with BaseRemoteSource {
  /// 活动列表
  Future<List<ActivityListItem>> activityList() {
    final dioReq = dioClient.post(
      '/aiera/v2/hotdog/newbie_draw/activity_list',
    );
    return callApiWithErrorParser(dioReq).then((res) {
      try {
        ActivityListModel obj = ActivityListModel.fromJson(res.data);
        return obj.data ?? [];
      } catch (e) {
        logger.e(e.toString());
        return [];
      }
    });
  }

  /// 邀请记录列表
  Future<List<RecordListItem>> recordList({int page = 1, int pageSize = 10}) {
    final dioReq = dioClient.post(
      '/aiera/v2/hotdog/newbie_draw/record_list',
      data: {
        'page': page,
        'page_size': pageSize,
      },
    );
    return callApiWithErrorParser(dioReq).then((res) {
      try {
        RecordListModel obj = RecordListModel.fromJson(res.data);
        return obj.data ?? [];
      } catch (e) {
        logger.e(e.toString());
        return [];
      }
    });
  }

  /// 邀请人信息
  Future<UserInfoModel?> userInfo() {
    final dioReq = dioClient.post(
      '/aiera/v2/hotdog/newbie_draw/user_info',
    );
    return callApiWithErrorParser(dioReq).then(
      (res) => res.data['code'] == 0
          ? UserInfoModel.fromJson(res.data['data'])
          : null,
    );
  }
}
```

# prop
```dart
// web url encode
String originalUrl = 'https://www.example.com/搜索/编码测试';
String encodedUrl = Uri.encodeFull(originalUrl);
```

# predict_trends
* 
```yaml
# 每次更新打 tag 可获取最新包，或者是 commit hash(提交记录哈希值)
# 确保最新可 /Users/bd/.pub-cache/git/k_chart-36712b6b6cfba2a52043f51f7bae5c33b3e4852e 删除后 get，再打开看是否有最新代码
k_chart:
  git:
    url: https://github.com/helloDolin/k_chart.git
    ref: 0.0.2
```
* 原生端 pop 时，需要手动释放 timer
* list 拼装为 list 套 list，利用带排序的 Map，key 为 时间，value 为 [] （flutter_sticky_header）
```dart
List<HistoryInfo> listData = [];

void _buildData() {
  // 组装数据（LinkedHashMap：有序 map）
  listData.clear();
  LinkedHashMap<String, List<HistoryListItem>> groupData = LinkedHashMap();
  for (HistoryListItem element in _resData) {
    if (!groupData.containsKey(element.beatsTime)) {
      groupData[element.beatsTime] = [];
    }
    groupData[element.beatsTime]!.add(element);
  }

  List<HistoryInfo> temp = [];
  groupData.forEach((key, value) {
    HistoryInfo obj = HistoryInfo();
    obj.beatsTime = key;
    obj.historyList = value;
    temp.add(obj);
  });
  listData.addAll(temp);
}

/// 拼装展示用的模型
class HistoryInfo {
  String? beatsTime;
  List<HistoryListItem>? historyList;
}
```
* publish_to: none 消除 git 或 本地引用的警告

# shell_market
* ScreenUtil 导致 Scaffold 键盘无法弹起（需要设置 useInheritedMediaQuery: true,） 
* num、double 转 int， .toInt()，直接截取不会四舍五入
* 多个 Future 执行，如果不 await 也是乱序的，不用使用 Future.wait(),Future.wait()更适合 group 的场景
```dart
// 下拉刷新时记得执行 resetNoData
  final int pageSize = 10;
  int curPage = 1;
  List<OtherListItem> listData = [];
  bool canLoad = true;

void onRefresh() {
  reqData(isRefresh: true).then((_) {
    refreshController.refreshCompleted();
    refreshController.resetNoData();
  }).catchError((_) {
    refreshController.refreshFailed();
    refreshController.resetNoData();
    // 接口失败需要触发 bool get showEmpty => requested && listData.isEmpty; 逻辑
    update();
  });
}

void onLoading() {
  if (canLoad) {
    reqData(isRefresh: false).then((_) {
      refreshController.loadComplete();
    }).catchError((_) {
      refreshController.loadFailed();
    });
  } else {
    refreshController.loadNoData();
  }
}

Future<void> reqData({bool isRefresh = false}) async {
  if (isRefresh) {
    curPage = 1;
    listData.clear();
  } else {
    curPage++;
  }

  List<PropListItem> res = await callDataService(
    req.propList(curPage, pageSize),
    onStart: () {},
    onComplete: () {},
  );
  listData.addAll(res);
  canLoad = res.length == pageSize;
  // 下拉刷新时不展示没有数据了
  if (!canLoad && !isRefresh) {
    refreshController.loadNoData();
  }
  update();
}
```

# 分页
是否最后一页求余方式是否有问题？有问题，求余为 0，页数刚好为 pagesize 的倍数会出问题
当前页不满一页也有问题：假设 size 为 10，刚好 30 条数据，会造成多调用一次上拉加载更多动作的接口

# 获取图片宽高等信息
```dart
final image = Image.network(img);
Completer<ui.Image> completer = Completer<ui.Image>();
image.image
    .resolve(const ImageConfiguration())
    .addListener(ImageStreamListener((ImageInfo info, bool _) {
  completer.complete(info.image);
}));

ui.Image info = await completer.future;
int width = info.width;
int height = info.height;
containerTopPadding = Get.width / (width / height) - 60;
update();
```

# Completer
```dart
void _testComplete() {
  final complete1 = Completer<void>();
  final complete2 = Completer<void>();
  final complete3 = Completer<void>();

  Future.delayed(Duration(seconds: 3), () {
    print(1111);
    complete1.completeError('❌❌❌ error');
  });
  Future.delayed(Duration(seconds: 1), () {
    print(2222);
    complete2.complete();
  });
  Future.delayed(Duration(seconds: 2), () {
    print(3333);
    complete3.complete();
  });

  Future.wait([complete1.future, complete2.future, complete3.future])
      .then((value) => print(value.length))
      .whenComplete(() => print('whenComplete'))
      .catchError((er) {
    print(er.toString());
  });
}
```

# 函数
```dart
// 函数类型
typedef Operation = num Function(num);

num add(num a, num b, Operation op) {
  return op(a) + op(b);
}

num square(num a) {
  return a * a;
}

// 第三个参数需满足 Operation 类型
add(2, 5, square);

// 第三个参数传 lambda 函数
add(2, 5, (num n) => n * n);
```

# Flutter 为何无法抓包
Flutter 不会主动使用系统代理

# clamp
```dart
int min = 10;
int max = 15;
print(6.clamp(min, max)); // 10
print(9.clamp(min, max)); // 10
print(14.clamp(min, max)); // 14
print(16.clamp(min, max)); // 15
print(18.clamp(min, max)); // 15

```

# scroll 滚动到顶部、底部
```dart
scrollController.animateTo(
  scrollController.position.minScrollExtent,
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
);

scrollController.animateTo(
  scrollController.position.maxScrollExtent,
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
);
```
# Image fit
如果在 Image.network 中不指定 fit 属性，它的默认行为是按照图片的原始尺寸显示，并尽量在给定的框内展示整个图片。

这个默认行为被称为 BoxFit.contain，它会尽量保持图片原始比例，同时确保图片完整地展示在给定的容器内。如果图片比例与容器不匹配，可能会在容器周围留有空白。

# TextFormField
```dart
TextFormField(
  autovalidateMode: AutovalidateMode.onUserInteraction,
  decoration: const InputDecoration(
    labelText: 'Enter your email',
    border: OutlineInputBorder(),
  ),
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  },
),
```

# TextField
```dart
// 常用属性
controller
autofocus
cursor: // 光标相关
textCapitalization: // 首字母大写、首句大写，全部小写设置
keyboardType: const TextInputType.numberWithOptions(decimal: false)
style
inputFormatters: <TextInputFormatter>[
  // 只允许输入大于 1 的整数
  FilteringTextInputFormatter.allow(RegExp(r'^[1-9]\d*$')),
],
maxLines: 10, // 最大行数，如果不设置最小行数，默认占 10 行空间
minLines: 1,
maxLength: 200, // 设置这个值，右下角会显示当前输入字符个数，不需要的话需要设置 decoration 下 counterText 为空
// 注：prefix、suffix 只有在选中状态下才会显示,常显示的是 prefixIcon、suffixIcon，但高度自定义的话也用不到
decoration: InputDecoration(
  contentPadding:
      const EdgeInsets.fromLTRB(5, 0, 5, 0),
  border: const OutlineInputBorder(
    borderSide: BorderSide.none,
  ),
  counterText: '',
  hintText: '请输入',
  hintStyle: TextStyle(
      fontSize: 14.sp,
      color: const Color(0xFFCCCCCC)),
  suffix: Text(
    '元',
    style: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF111111),
    ),
  ),
),
```
```dart
// 光标挪到最后
_textEditingNumController.selection =
TextSelection.collapsed(
    offset: _textEditingNumController
        .text.length);
```
# Inkwell 和 GestureDetector 区别
1. 一个有水波纹效果（自定义 widget 需要嵌套 Ink），一个没有
2. GestureDetector 支持的手势更丰富
# 带水波纹效果按钮
```dart
// Inkwell 在包裹 container 且有颜色有圆角时，水波纹效果仅在圆角与区域外有效
// container 不能设置颜色，颜色需要 Ink 组件提供
// 所以最好还是用 ElevatedButton
InkWell(
  splashColor: Colors.yellow,
  // focusColor: Colors.green,
  onTap: () {},
  child: Ink(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0), // 可根据需求调整圆角
    ),
    child: Container(
      alignment: Alignment.center,
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        // color: const Color(0xFFe5e5e5),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: const Color(0xFF00FFFF),
          width: 10,
        ),
      ),
      child: Text(
        'text',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF000000),
        ),
      ),
    ),
  ),
)

ElevatedButton(
  onPressed: () {
    Get.back();
  },
  style: ButtonStyle(
    // 设置圆角
    shape:
        MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    ),
    // 设置宽高
    minimumSize:
        MaterialStateProperty.all<Size>(Size(192.w, 40.w)),
    backgroundColor: MaterialStateProperty.all<Color>(
      model.betMarket == 1
          ? const Color(0xFFFF3B30)
          : const Color(0xFF34C759),
    ),
  ),
  child: Text(
    '确定',
    style: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w900,
      color: const Color(0xFFFFFFFF),
    ),
  ),
),
```

# 监听键盘弹起落下
```dart
with WidgetsBindingObserver

WidgetsBinding.instance.addObserver(this);
WidgetsBinding.instance.removeObserver(this);

@override
void didChangeMetrics() {
  super.didChangeMetrics();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (MediaQuery.of(Get.context!).viewInsets.bottom == 0) {
      debugPrint('键盘收回');
    } else {
      debugPrint('键盘弹出' '😄 ${scrollController.position.maxScrollExtent}');
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  });
}
```
# 保存 Widget 为图片到相册
```dart
// toImage
// gallery_saver: ^2.3.2
Future<String?> toImage(GlobalKey globalKey, BuildContext ctx) async {
  try {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(
        pixelRatio: MediaQuery.devicePixelRatioOf(ctx));
    ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uInt8List = byteData!.buffer.asUint8List();
    Directory directory = await getTemporaryDirectory();
    final file = await File('${directory.path}/share_temp.png').create();
    await file.writeAsBytes(uInt8List);
    return file.path;
  } catch (e) {
    return null;
  }
}

// 使用如下方法更好
Future<Uint8List?> _getBitsByKey(GlobalKey key) async {
  RenderObject? boundary = key.currentContext?.findRenderObject();
  if (boundary != null && boundary is RenderRepaintBoundary) {
    ui.Image img = await boundary.toImage(pixelRatio: 2);
    ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? bits = byteData?.buffer.asUint8List();
    return bits;
  }
  return null;
}

// save
try {
  String? path = await toImage(globalKey, context);
  await GallerySaver.saveImage(path!);
  Fluttertoast.showToast(
    msg: '已保存到相册',
    gravity: ToastGravity.CENTER,
  );
} catch (e) {
  Fluttertoast.showToast(
    msg: '保存失败',
    gravity: ToastGravity.CENTER,
  );
}

// 注：需要在 widget 组件上包裹 RepaintBoundary 并设置 key
```

# 监听 TabController index 打印两次 + 监听 TabController 动画

```dart
// 看源码：在动画开始前 notify 一次，动画结束后 notify 一次。所以调用了两次
// 所以在监听 index 前加上判断：
if (tabController.indexIsChanging) {
    print("监听切换tab ${tabController.index} ");
}

// 监听 TabController 动画
tabController.animation!.addListener(() {
    tabIsChanging.value =
        tabController.animation!.value != tabController.index;
    if (!tabIsChanging.value) {
      if (tabController.index == 0) {
        rightTopBtn.value = RightTopBtn.history;
      } else if (tabController.index == 1) {
        rightTopBtn.value = RightTopBtn.boxBitch;
      }
    }
  });
```

# AnnotatedRegion 
是 Flutter 中的一个小部件，用于在应用程序的特定区域内设置系统UI（如状态栏、导航栏等）的样式。它通常用于定制某个页面或部分页面的系统UI样式，而不是整个应用程序。

在移动设备上，系统UI通常包括状态栏（显示时间、电池状态等信息的区域）和导航栏（位于屏幕底部的虚拟按钮区域，如返回按钮、主屏幕按钮等）。在某些情况下，您可能想要为应用程序的特定页面或特定部分的页面更改这些系统UI的样式，例如改变状态栏的颜色、透明度等。

iOS 下需要配置 plist
```xml
<key>UIStatusBarHidden</key>
<false/>
<key>UIViewControllerBasedStatusBarAppearance</key>
<false/>
```
## 设置 AppBar 背景色，状态栏颜色会自动修改（亲测有效 iOS）
AppBar backgroundColor

## 三种方式改变状态栏颜色
```dart
// 1.通过 SystemChrome 修改
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark); // SystemUiOverlayStyle.light
// 2. 通过 AnnotatedRegion 修改
@override
Widget build(BuildContext context) {
  return AnnotatedRegion(
    value: SystemUiOverlayStyle.dark, // SystemUiOverlayStyle.light
    child: Container(),
  );
}
// 3.通过 AppBar 修改
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark, // SystemUiOverlayStyle.light
    ),
    body: Container(),
  );
}

// 使用的方案
```dart
AnnotatedRegion(
  value: SystemUiOverlayStyle(
    // Status bar color for android
    statusBarColor: statusBarColor(),
    statusBarIconBrightness: statusBarIconBrightness(),
    // Only honored in iOS
    statusBarBrightness: iosStatusBarBrightness,
  ),
  child: Material(
    color: Colors.transparent,
    child: pageScaffold(context),
  ),
);
```

# Scaffold resizeToAvoidBottomInset 属性
是一个布尔值属性，用于控制当键盘弹出时，Scaffold是否会自动调整自身的大小以避免被底部插入（即避免键盘覆盖底部内容）
 
# RefreshConfiguration.copyAncestor

# getx controller worker中 debounce 防抖
缺点：需要传入一个 listener，如果多个地方都需要防抖，需要传入多个 listener，比较麻烦

# listEquals 
比较两个数组内容、位置是否相同

# where 使用(任务抽查那个可以用 every、any 替换)
```dart
bool b2 = bigCar
        .where((element) =>
            element.leftUrl.isEmpty && element.rightUrl.isEmpty)
        .length ==
    bigCar.length;
bool b3 = smallCar
        .where((element) =>
            element.leftUrl.isEmpty && element.rightUrl.isEmpty)
        .length ==
    smallCar.length;
```

# ValueListenableBuilder 、 ListenableBuilder 使用
ValueNotifier<bool> commitBtnEnabled = ValueNotifier(false); 控制刷新颗粒度
```dart
// Listenable 还可以 merge，简直 666
Listenable.merge([controller, controller])

// eg:
ValueNotifier<Duration> _duration = ValueNotifier(Duration.zero);

Widget buildStopwatchPanel() {
  double radius = MediaQuery.of(context).size.shortestSide / 2 * 0.75;
  return ValueListenableBuilder<Duration>( 
      valueListenable: _duration,
      builder: (_, value, __) => StopwatchWidget(
            radius: radius,
            duration: value,
            themeColor: Theme.of(context).primaryColor,
            secondDuration: _secondDuration,
          ));
}
```

# Flutter 异步结束回调（类 iOS 并发 group 功能）
```dart
Future<void> test1() async {
  await Future.delayed(Duration(seconds: 1), () => print('11111'));
}

Future<void> test2() async {
  // throw '123';
  await Future.delayed(Duration(seconds: 3), () => print('222222'));
}

Future.wait([test1(), test2()])
      .then((value) => print('哈哈😄'))
      .whenComplete(() => print('whenComplete'))
      .catchError((error) {
    print(error);
  });
// whenComplete 在所有 Future 结束之后调用，即使有些 Future 抛出异常
// 注意：1.当 Future 抛出异常时，then 不会执行，catchError 会执行
// 2.传入的 Future 如果返回 void 需要 await 一下
```

# pubspec.yaml 中的版本号+构建号
> The following defines the version and build number for your application. A version number is three numbers separated by dots, like 1.2.43 followed by an optional build number separated by a +. Both the version and the builder number may be overridden in flutter build by specifying --build-name and --build-number, respectively. Read more about versioning at semver.org.

version: 1.0.0+1

# 弹框
showDialog()
```dart
    showDialog(
      context: Get.context!,
      barrierColor: Colors.black12,
      barrierDismissible: false, // 点击蒙版关闭
      builder: (cxt) => Center(
        // 防止文本下面有双黄线
        child: Material(
          // material 颜色设为透明，否则子 widget 圆角会有颜色
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.colorLightGreen,
              borderRadius: BorderRadius.all(
                Radius.circular(12.w),
              ),
            ),
            padding: EdgeInsets.all(25.w),
            width: 320.w,
            height: 178.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'title\nsubtitle',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: const Color(0xFF111111),
                      fontWeight: FontWeight.w600,
                      fontSize: 17.sp),
                ),
                SizedBox(
                  height: 25.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 130.w,
                      height: 44.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(cxt);
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFFF2F2F2)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.w))),
                        ),
                        child: Text(
                          '取消',
                          style: TextStyle(
                              fontSize: 16.0.sp,
                              color: const Color(0xFF666666),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 130.w,
                      height: 44.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(cxt);
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF222222)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.w))),
                        ),
                        child: const Text(
                          '确定合成',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
```
showModalBottomSheet() 若底部弹框有输入框且在键盘弹起要看到底部，需要添加 isScrollControlled: true,
```dart
    showModalBottomSheet(
      barrierColor: Colors.black12, // 蒙版颜色
      // isScrollControlled: true, // 是否可滚动，有键盘时考虑使用
      isDismissible: true, // 点击外部关闭
      enableDrag: true, // 拖拽关闭弹框
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),

      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      useSafeArea: true,
      backgroundColor: Colors.orange, // Get.theme.cardColor,
      // backgroundColor: Colors.red,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text("复制链接"),
              onTap: () {
                Get.back();
                // ClipboardUtil.setDataToast(url);
              },
            ),
            Visibility(
              visible: content.isNotEmpty,
              child: ListTile(
                leading: const Icon(Icons.copy),
                title: const Text("复制标题与链接"),
                onTap: () {
                  Get.back();
                  // ClipboardUtil.setDataToast("$content\n$url");
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.public),
              title: const Text("浏览器打开"),
              onTap: () {
                Get.back();
                // launchUrlString(url, mode: LaunchMode.externalApplication);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text("系统分享"),
              onTap: () {
                Get.back();
                // Share.share(content.isEmpty ? url : "$content\n$url");
              },
            ),
          ],
        ),
      ),
    );
```
 
## 弹框里有输入框随键盘弹起位置变化
1. 用 Scaffold
```dart
// eg:
showDialog(
      context: context,
      builder: (context) {
        return Material(
          type: MaterialType.transparency,
          // animationDuration: const Duration(seconds: 2),
          child: Center(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              // padding: EdgeInsets.only(
              // bottom: MediaQuery.of(context).viewInsets.bottom),
              body: Center(
                child: Container(
                    alignment: Alignment.bottomCenter,
                    color: Colors.red,
                    width: double.infinity,
                    height: 300,
                    child: Column(
                      children: const [
                        TextField(),
                        TextField(),
                      ],
                    )),
              ),
            ),
          ),
        );
      },
    );
```
2. 外层套 Padding
```dart
showDialog(
      context: context,
      builder: (context) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                  alignment: Alignment.bottomCenter,
                  color: Colors.red,
                  width: double.infinity,
                  height: 300,
                  child: Column(
                    children: const [
                      TextField(),
                      TextField(),
                    ],
                  )),
            ),
          ),
        );
      },
    );
```

# Scaffold.of(context).openEndDrawer() 报错或者不生效
外层包一个 Builder，因为 Scaffold.of 找的是父级

# 实用 Widget
FittedBox
SafeArea
LayoutBuilder
OrientationBuilder
DefaultTextStyle
IconTheme
SingleChildScrollView
InteractiveViewer （让用户在子组件上执行平移、缩放和旋转等手势操作）

# Key
* 对多子组件中的组件进行交换、移除、增加等变化时，通过添加 Key 让元素可以感知变化，保证正确的关系，不至于状态类的混乱
* key 的作用就是为 Widget 确认唯一的身份，可以在多子组件更新中被识别，这就是 LocalKey 的作用,所以 LocalKey 保证的是 相同父级 组件的身份唯一性
* 而 GlobalKey 是整个应用中，组件的身份唯一性
```dart
// eg:
// 选中第一个后，删除第一个 Box，保存后剩下的两个的第一个也被选中了
Row(
  children: [Box(), Box(), Box()],
),

class _BoxState extends State<Box> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.red,
      child: Checkbox(
          value: isChecked,
          onChanged: ((value) {
            setState(() {
              isChecked = value!;
            });
          })),
    );
  }
}
```

# await 之后使用 context 可能会有风险
context 也就是 element，await 之后，element 有可能已经不是那个 element 了，也有可能 element 被释放了