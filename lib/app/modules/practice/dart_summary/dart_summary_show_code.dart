// 混入：打印工具混入
import 'package:flutter/foundation.dart';

mixin PrintHelper {
  void printInfo() => debugPrint(getInfo());
  String getInfo();
}

class Meta {
  // 构造函数语法糖
  Meta(this.name, this.price);
  String name;
  double price;
}

class Item extends Meta {
  Item(super.name, super.price) : assert(price > 0.0, '价格必须大于 0');

  // 重载 + 运算符，合并商品
  Item operator +(Item other) => Item(name + other.name, price + other.price);
}

class ShoppingCart extends Meta with PrintHelper {
  // 默认初始化函数，转发至 withCode 函数
  ShoppingCart({String? name}) : this.withCode(code: '', name: name);
  // 命名构造函数
  // 实例化之前初始化实例变量 dateTime
  ShoppingCart.withCode({
    required this.code,
    String? name,
  })  : dateTime = DateTime.now(),
        super(name ?? '', 0);
  DateTime dateTime;
  String code;
  late List<Item> bookings;

  // override price 作为购物车总价
  @override
  double get price =>
      bookings.reduce((value, element) => value + element).price;

  @override
  String getInfo() {
    return '''
购物车信息
==========================
用户名：$name
优惠码：$code
总价：$price
日期：$dateTime
==========================
    ''';
  }

  /**
   * is 关键字判断类型
   * a ~/ b 取整. python 中 // 为取整 ** 幂
   * int.parse(str)
   * isNaN eg:0/0
   * a = 10 b = a++ 先赋值再运算
   * a = 10 b = ++a 先运算再赋值
   * list.filled(2,'1') list 固定长度 + 初始化
   * list:foreach where any every fold
   * 如果说 命名参数 是为了方便使用而允许乱序，提供名称传参；那么 位置参数 就是不允许乱序，依次传参。
   */
}
