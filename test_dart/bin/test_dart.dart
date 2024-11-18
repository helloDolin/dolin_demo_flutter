import 'dart:async';

import 'abstract_class.dart';
import 'enum.dart';
import 'list.dart';
import 'normal_class.dart';
import 'reg_exp.dart';
import 'req_group.dart';
import 'singleton_class.dart';

Future<void> req1() async {
  await Future.delayed(Duration(seconds: 3), () => print('11111'));
}

Future<void> req2() async {
  // throw Exception('异常测试');
  await Future.delayed(Duration(seconds: 3), () => print('222222'));
}

Future<String> test() async {
  return '123';
}

enum Type {
  a,
  b,
  c,
  d,
}

typedef Operation = num Function(num);

num add(num a, num b, Operation op) {
  return op(a) + op(b);
}

num square(num a) {
  return a * a;
}

String numberToChinese(int number) {
  const chineseNumbers = ['零', '一', '二', '三', '四', '五', '六', '七', '八', '九'];
  const chineseUnits = ['', '十', '百', '千', '万'];

  if (number == 0) {
    return chineseNumbers[0];
  }

  List<String> chineseDigits = [];
  int digitIndex = 0;

  while (number > 0) {
    int digit = number % 10;
    if (digit != 0) {
      chineseDigits.insert(0, chineseUnits[digitIndex]);
      chineseDigits.insert(0, chineseNumbers[digit]);
    } else if (chineseDigits.isNotEmpty &&
        chineseDigits.first != chineseNumbers[0]) {
      chineseDigits.insert(0, chineseNumbers[digit]);
    }
    digitIndex++;
    number ~/= 10;
  }

  return chineseDigits.join('');
}

abstract class Base {
  int a = 10;
  void say();
  void sing();
  void can() {
    print('what can you do?');
    say();
    sing();
  }
}

class Test extends Base {
  @override
  void say() {
    // TODO:
    print('implement say');
  }

  @override
  void sing() {
    // TODO: implement sing
    print('implement sing');
  }
}

void _testDoubleNumOverflow() {
  print(double.parse('0.5263') * 100);
}

void _testComplete() {
  final complete1 = Completer<void>();
  final complete2 = Completer<void>();
  final complete3 = Completer<void>();

  Future.delayed(Duration(seconds: 3), () {
    print(1111);
    complete1.completeError('❌❌❌ error');
  });
  Future.delayed(Duration(seconds: 1), () {
    print(2222);
    complete2.complete();
  });
  Future.delayed(Duration(seconds: 2), () {
    print(3333);
    complete3.complete();
  });

  Future.wait([complete1.future, complete2.future, complete3.future])
      .then((value) => print(value.length))
      .whenComplete(() => print('whenComplete'))
      .catchError((er) {
    print(er.toString());
  });
}

int get getWillFromBirth2TodayDays {
  DateTime now = DateTime.now();
  DateTime birthday = DateTime(2024, 5, 28);
  Duration diff =
      now.difference(DateTime(birthday.year, birthday.month, birthday.day));
  return diff.inDays + 1;
}

(int, double, String) recordTest() {
  return (18, 70.88, 'name');
}

void main(List<String> arguments) async {
  String originalUrl1 =
      'https://www.baidu.com/s?ie=utf-8&f=3&rsv_bp=1&rsv_idx=1&tn=baidu&wd=%E5%8D%97%E7%BF%94%E6%98%9F%E5%9F%8E%E5%8D%AB%E7%94%9F%E6%9C%8D%E5%8A%A1%E4%B8%AD%E5%BF%83%E7%94%B5%E8%AF%9D&fenlei=256&rsv_pq=0x8da94a7200e5489b&rsv_t=fee23K77MxBG6qGpOj9kSyps1jBtfUp2Z3lzGqfKZFZ9iyvKxwLzV6zxiKc&rqlang=en&rsv_dl=ts_0&rsv_enter=1&rsv_sug3=19&rsv_sug1=10&rsv_sug7=100&rsv_sug2=0&rsv_btype=i&prefixsug=%25E5%258D%2597%25E7%25BF%2594%25E6%2598%259F%25E5%259F%258E&rsp=0&inputT=7937&rsv_sug4=7938';
  String originalUrl2 = 'https://www.example.com/搜索/编码测试?asdf=123&哈哈=嘿嘿';

  String encodedUrl = Uri.encodeFull(originalUrl2);
  String newUrl = Uri.decodeFull(encodedUrl);
  print(newUrl);
  Uri uri = Uri.parse(newUrl);
  print(uri.scheme);
  print(uri.host);
  print(uri.port);
  print(uri.path);
  Map<String, String> queryParams = uri.queryParameters;
  queryParams.forEach((key, value) {
    print('$key: $value');
  });
  return;

  print(getWillFromBirth2TodayDays);
  print('================================================');

  _testComplete();
  // return;

  _testDoubleNumOverflow();
  print('================================================');

  Test t = Test();
  t.can();
  print(t.a);
  print('================================================');

  print(10 * 2 * 2 * 2 * 2);
  print(10 << 4);

  print('================================================');
  List a = [1, 2, 3, 4];
  List b = ['a', 'b', 'c', 'd'];
  Map map = Map.fromIterables(a, b);
  print(map);

  print('================================================ 转二进制');
  print(10.toRadixString(2));
  print(20.toRadixString(2));

  print('================================================ &、|、~、^');
  print(65 & 11);
  print(65 | 11);
  print(~65);
  int num1 = 10;
  int num2 = 20;
  num1 = num1 ^ num2;
  print(num1);
  num2 = num1 ^ num2;
  print(num2);
  num1 = num1 ^ num2;
  print(num1);
  print('$num1 --- $num2');

  print('================================================ 函数签名作为入参');
  add(2, 5, square);
  add(2, 5, (num n) => n * n);

  print('================================================ enum');
  print(Type.values);
  print(Type.values.firstWhere(
    (element) => element.index == 110,
    orElse: () => Type.d,
  ));

  String src = '光绪七年辛巳年八月初三（1881年9月25日），出生于浙江绍兴城内东昌坊新台门周家。幼名阿张，长根，长庚，学名周樟寿。';
  RegExp exp = RegExp(r'(\d{1,4})年(\d{1,2})月(\d{1,2})');
  Iterable<RegExpMatch> allMatches = exp.allMatches(src);

  for (RegExpMatch match in allMatches) {
    print("groupCount:${match.groupCount}====match:${match.group(0)}");
    print("groupCount:${match.groupCount}====match:${match.group(1)}");
    print("groupCount:${match.groupCount}====match:${match.group(2)}");
    print("groupCount:${match.groupCount}====match:${match.group(3)}");
  }
  // num a = 123.456;
  // double b = 798.9;
  // print(a.toInt());
  // print(b.toInt());
  // return;

  // abstract class
  Humen(age: 33);

  // RegExp
  print('===================================== RegExp');
  print(getUnit());
  deleteUnit('123.11ppm');
  print(splitExpression("").last);

  // Object mixin
  print('===================================== Object mixin');
  Student stu = Student();
  print(stu);
  print(stu is Play);
  print(stu.playName());

  print('===================================== 官方单例举例');
  print(
      'https://flutter.cn/community/tutorials/singleton-pattern-in-flutter-n-dart');
  print(Singleton() == Singleton());
  print(identical(Singleton(), Singleton()));

  // list
  print('===================================== list');
  test_list();

  // enum
  print('===================================== enum');
  print(PortType.typeC.name);
  print(PortType.typeC.isUSB);

  // req group
  print('===================================== req group');
  executeGroup();
}
