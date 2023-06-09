# 弹框
showDialog()
showModalBottomSheet() 若底部弹框有输入框，需要添加 isScrollControlled: true,

 
## 弹框里有输入框随键盘弹起位置变化
1. 用 Scaffold
2. 外层套 Padding
```dart
// MediaQuery.of(context).viewInsets.bottom：键盘高度
Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
)
```

# WillPopScope 正确用法
```dart
// 直接 return true或false 会阻止 iOS 手势
// so，按下面方式使用，具体原因看源码
onWillPop: controller.canPop() ? null : () async => false,
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