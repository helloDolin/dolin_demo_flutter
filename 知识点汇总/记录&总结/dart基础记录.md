# AnnotatedRegion 
是 Flutter 中的一个小部件，用于在应用程序的特定区域内设置系统UI（如状态栏、导航栏等）的样式。它通常用于定制某个页面或部分页面的系统UI样式，而不是整个应用程序。

在移动设备上，系统UI通常包括状态栏（显示时间、电池状态等信息的区域）和导航栏（位于屏幕底部的虚拟按钮区域，如返回按钮、主屏幕按钮等）。在某些情况下，您可能想要为应用程序的特定页面或特定部分的页面更改这些系统UI的样式，例如改变状态栏的颜色、透明度等。

# resizeToAvoidBottomInset 
是一个布尔值属性，用于控制当键盘弹出时，Scaffold是否会自动调整自身的大小以避免被底部插入（即避免键盘覆盖底部内容）
 
# RefreshConfiguration.copyAncestor

# getx controller debounce 防抖

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

# ValueListenableBuilder、ListenableBuilder 使用
ValueNotifier<bool> commitBtnEnabled = ValueNotifier(false); 控制刷新颗粒度
```dart
// Listenable 还可以 merge，简直 666
Listenable.merge([controller, controller])
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
showModalBottomSheet() 若底部弹框有输入框，需要添加 isScrollControlled: true,
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
InteractiveViewer（让用户在子组件上执行平移、缩放和旋转等手势操作）

# Key
* 对多子组件中的组件进行交换、移除、增加等变化时，通过添加 Key 让由于元素可以感知变化，保证正确的关系，不至于状态类的混乱
*key 的作用就是为 Widget 确认唯一的身份，可以在多子组件更新中被识别，这就是 LocalKey 的作用,所以 LocalKey 保证的是 相同父级 组件的身份唯一性
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

# 性能提升
* RepaintBoundary 当一个局部的组件，会频繁地触发更新，你不想让他影响其他区域时。最常见的场景是 动画 、循环定时器 、滑动操作,考虑使用 RepaintBoundary 包裹（这也是为什么 ListView 在默认情况下，会为每个条目都套上一个 RepaintBoundary 的原因）

# await 之后使用 context 可能会有风险
context 也就是 element，await 之后，element 有可能已经不是那个 element 了，也有可能 element 被释放了