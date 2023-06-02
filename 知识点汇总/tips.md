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

