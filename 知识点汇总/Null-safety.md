# 官方
Null pointer exceptions are the largest cause of app crashes on Goole Play

Non-nullable
Nullable

# 本质
空安全的本质变化是 null 从 Object 类族中脱离，自成一派，

```dart
void main(){
  String? name = null;
  print(name is Object); // false
  print(name is String); // false
  print(name is Null); // true
}
```
# 好处、作用
* 尽量把空指针错误从运行时错误转为编译时错误
* AOT 后，大大减少编译器产生的代码，会提升运行效率


# 标注旧的语法，但是 2023 之后强制空安全
//@dart=2.10

# ？
可为空

# ！
人为，保证不为空

# late
1. 稍后赋值
2. 立即赋值，但是在使用时才调用后边
3. 所有的全局变量默认加了 late（👍🏻）
eg:
```dart
late final AnimationController _ac = AnimationController(
    vsync: this, // 屏幕刷新时可以得到一次回传,eg:一秒回传 60 或者 120 次
    duration: const Duration(seconds: 1),
    lowerBound: 0.0,
    upperBound: 1.0,
  )..addListener(() {
      print('animation controller value: ${_ac.value}');
    });
```

# 健全的空安全
💪🏻 Running with sound null safety 💪🏻






