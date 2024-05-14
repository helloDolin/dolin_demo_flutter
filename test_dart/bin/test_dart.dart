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

void main(List<String> arguments) async {
  _testDoubleNumOverflow();
  Test t = Test();
  t.can();
  print(t.a);

  print(10 * 2 * 2 * 2 * 2);
  print(6 >> 2);

  List a = [1, 2, 3, 4];
  List b = ['a', 'b', 'c', 'd'];
  Map map = Map.fromIterables(a, b);
  print(map);

  print(10.toRadixString(2));
  print(20.toRadixString(2));

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
  add(2, 5, square);
  add(2, 5, (num n) => n * n);

  print(Type.values);
  print(Type.values.firstWhere(
    (element) => element.index == 110,
    orElse: () => Type.d,
  ));
  // return;

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
  excuteGroup();
}
