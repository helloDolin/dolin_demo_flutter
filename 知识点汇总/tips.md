# pubspec.yaml 中的版本号+构建号
> The following defines the version and build number for your application. A version number is three numbers separated by dots, like 1.2.43 followed by an optional build number separated by a +. Both the version and the builder number may be overridden in flutter build by specifying --build-name and --build-number, respectively. Read more about versioning at semver.org.

version: 1.0.0+1

# 弹框
showDialog()
TODO: showDialog 有文本输入，参考 merchant 自动向上平移
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
InteractiveViewer

# Key
当状态类中有私有成员，对多子组件中的组件进行交换、移除、增加等变化时，通过添加 Key 让由于元素可以感知变化，保证正确的关系，不至于状态类的混乱
key 的作用就是为 Widget 确认唯一的身份，可以在多子组件更新中被识别，这就是 LocalKey 的作用
所以 LocalKey 保证的是 相同父级 组件的身份唯一性。
而 GlobalKey 是整个应用中，组件的身份唯一

# 性能提升
那什么时候该用 RepaintBoundary 呢？很简单，当一个局部的组件，会频繁地触发更新，你不想让他影响其他区域时。最常见的场景是 动画 、循环定时器 、滑动操作 等
这也是为什么 ListView 在默认情况下，会为每个条目都套上一个 RepaintBoundary 的原因

# 在 RendererBinding#drawFrame 的注释中，介绍了一帧的 8 个阶段，其中的 3~7 都是和 PipelineOwner 相关的流程。另外三个是和 SchedulerBinding 调度相关的。

1. The animation phase: 动画阶段
2. Microtasks: 微任务阶段
3. The layout phase: 布局阶段 =======================
4. The compositing bits phase: 合成位标记阶段        =
5. The paint phase: 绘制阶段                        = PipelineOwner
6. The compositing phase: 合成阶段                  =
7. The semantics phase: 语义阶段=====================
8. The finalization phase: 结束阶段 

# await 之后使用 context 可能会有风险
context 也就是 element，await 之后，element 有可能已经不是那个 element 了，也有可能 element 被释放了

