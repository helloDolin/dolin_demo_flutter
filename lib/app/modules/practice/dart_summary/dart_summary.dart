import 'package:dolin/app/common_widgets/code/code.dart';
import 'package:flutter/material.dart';

import 'dart_summary_show_code.dart' hide PrintHelper;
// import 'dart_summary_show_code.dart' show PrintHelper;

/*
如果说 命名参数 是为了方便使用而允许乱序，提供名称传参；那么 位置参数 就是不允许乱序，依次传参。

*/

const kDartCode = """
// 接口：打印工具抽象类
abstract class PrintHelper {
  void printInfo() => print(getInfo());
  String getInfo();
}

class Meta {
  // 构造函数语法糖
  Meta(this.name, this.price);
  String name;
  double price;
}

class Item extends Meta {
  Item(String name, double price)
      : assert(price > 0.0, '价格必须大于 0'),
        super(name, price);

  // 重载 + 运算符，合并商品
  Item operator +(Item item) => Item(name + item.name, price + item.price);
}

class ShoppingCart extends Meta with PrintHelper {
  DateTime dateTime;
  String code;
  late List<Item> bookings;

  // 命名构造函数
  // 实例化之前初始化实例变量 dateTime
  ShoppingCart.withCode({
    required this.code,
    String? name,
  })  : dateTime = DateTime.now(),
        super(name ?? '', 0);

  // 默认初始化函数，转发至 withCode 函数
  ShoppingCart({name}) : this.withCode(code: '', name: name);

  // override price 作为购物车总价
  @override
  double get price =>
      bookings.reduce((value, element) => value + element).price;

  @override
  String getInfo() {
    return '''
购物车信息
==========================
用户名：\$name
优惠码：\$code
总价：\$price
日期：\$dateTime
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
   * 可选参数、可选命名参数
   */
}


""";

class DartSummaryPage extends StatefulWidget {
  const DartSummaryPage({super.key});

  @override
  State<DartSummaryPage> createState() => _DartSummaryPageState();
}

class _DartSummaryPageState extends State<DartSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dart 温故知新'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            CodeWidget(
              code: kDartCode,
              style: HighlighterStyle.fromColors(HighlighterStyle.gitHub),
            )
          ],
        ),
      )),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          ShoppingCart obj = ShoppingCart.withCode(code: 'code', name: '京东')
            ..bookings = [
              Item('商品1', 12),
              Item('商品2', 13),
              Item('商品3', 14),
            ];
          obj.printInfo();

          var res = obj.bookings.fold<double>(
              10, (previousValue, element) => previousValue + element.price);
          print(res);
        },
        child: const Text('test dart code'),
      ),
    );
  }
}
