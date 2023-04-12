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
   * 可选参数、可选命名参数
   */
}
