import 'package:flutter/material.dart';

/// 抽象类（打印工具）
abstract class PrintHelper {
  void printInfo() => debugPrint(getInfo());
  String getInfo();
}

class Meta {
  // 成员变量初始化语法糖
  Meta(this.name, this.price);

  double price;
  String name;
}

class Item extends Meta {
  Item(name, price)
      : assert(name != null, 'name must not be null'),
        super(name, price);

  // 重载 + 运算符，合并商品为套餐商品
  Item operator +(Item item) => Item(name + item.name, price + item.price);
}

// class Item {
//   double price;
//   String name;
//   无语法糖的初始化
//   // Item(name, price) {
//   //   this.name = name;
//   //   this.price = price;
//   // }
//   Item(this.name, this.price);
// }

class ShoppingCart extends Meta with PrintHelper {
  //   无语法糖的初始化
  // ShoppingCart(name, code) {
  //   this.name = name;
  //   this.code = code;
  //   this.date = DateTime.now();
  // }

  // ShoppingCart(name, this.code)
  //     : date = DateTime.now(),
  //       super(name, 0); // 初始化时赋初值

  ShoppingCart.withCode({name, required this.code})
      : date = DateTime.now(),
        super(name, 0);

  // 默认初始化函数，转发至 withCode 函数
  ShoppingCart({name}) : this.withCode(name: name, code: '');

  DateTime date;
  String code;
  late List<Item> bookings;

  // 总价
  @override
  double get price =>
      bookings.reduce((value, element) => value + element).price;

  @override
  String getInfo() {
    return '''
购物车信息
==============================================
用户名：$name
优惠码：$code
总价：$price
日期：$date
==============================================
    ''';
  }

  // double get price {
  //   double sum = 0.0;
  //   for (var i in bookings) {
  //     sum += i.price;
  //   }
  //   return sum;
  // }

  // price() {
  //   double sum = 0.0;
  //   for (var i in bookings) {
  //     sum += i.price;
  //   }
  //   return sum;
  // }
}
