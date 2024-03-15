# RX
```dart
Rx<ShopInfoData> shopInfoData = ShopInfoData().obs; // 对象
Rx<FilterBtnStatus> unitStatus = FilterBtnStatus.down.obs; // 枚举
RxList<MarqueeInfo> marqueeInfos = <MarqueeInfo>[].obs; // 列表
final RxList<NoticeUiData> _noticProjectListController = RxList.empty(); // 列表
```
# 监听 rx 变量变化：
```dart
RxBool rightsItemSelect = false.obs;
rightsItemSelect.listen((res) { });
```

# 路由：
```dart
Future.wait([agreementCompleter.future, auditCompleter.future])
        .then((_) => Get.offAllNamed(Routes.HOME));

Get.offAndToNamed(Routes.WEBVIEW, arguments: qrcode);
```

# 状态管理
```dart
// GetX 的方式同 Obx
// You should only use GetX or Obx for the specific widget that will be updated.
GetX<CountController>(
    init: controller,
    initState: (_) {},
    builder: (_) {
    print("GetX - 4");
    return Text('value 4 -> ${_.count2}');
    },
),


// GetBuilder: 只有手动 update() 才会触发 builder

// ValueBuilder
ValueBuilder<int?>(
    initialValue: 10,
    builder: (value, updateFn) {
    return Column(
        children: [
        Text("count -> " + value.toString()),
        ElevatedButton(
            onPressed: () {
            updateFn(value! + 1);
            },
            child: Text('ValueBuilder -> add'),
        )
        ],
    );
    },
    // builder: (value, updateFn) => Switch(
    //   value: value,
    //   onChanged:
    //       updateFn, // same signature! you could use ( newValue ) => updateFn( newValue )
    // ),
    // if you need to call something outside the builder method.
    onUpdate: (value) => print("Value updated: $value"),
    onDispose: () => print("Widget unmounted"),
),
```