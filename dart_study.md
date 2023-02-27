# dart 温故创建
```
dart create dart_study
```

# 知识点
1. final const 区别：
final 赋值就不能改动，数组的话，里边元素可以改动，const 不行
属性一般定义为 final

2. 断言 assert

3. 或运算符，常量组合，eg：左上角，右上角。二进制：8421

4. 字符串拼接：""

"" 不需要 + 号，常量过长时可以使用这种方式美化代码

StringBuffer

strTest.split(',');
strTest.trim();
strTest.replaceAll('现有','替换为的')

5. DateTime.utc();  
DateTime.parse('');

z:0时区
eg:2023-2-24 21:51:15Z
eg:2023-2-24 21:51:15+0800

时间戳：dt.millisecondsSinceList 10位  

dt.microsecondsSinceEpoch 13位

6. list
```dart
  // 生成数据
  // 使用场景，row 的 children
  var ls1 = List.generate(10, (index) => index);
  print(ls1);

  var ls2 = [];
  ls2
    ..add(1)
    ..add(2)
    ..add(3)
    ..addAll([4, 5, 6]);
  print(ls2);
```

7. set
```dart
Set set1 = <String>{'1', '2', '3'};
Set set2 = <String>{'2', '3', '4'};
print(set1.intersection(set2).toList()); // 交集
print(set1.union(set2).toList()); // 并集
```

8. as: 类型转换，包名别名

is: a is String 返回 bool

9. continue 可以 continue 到指定流程位置类似 goto

eg：
```dart
switch(type):
    case left:
        print('left')
        continue hah;
    case right:
        print('right')
        continue hah;
    hah:
    case hah:
        print('hah')
        break;
    default:
        print('default')
```

10. Exception 可以捕获；
Error：系统错误；
自定义异常；
```dart
try {
    throw OutOfMemoryError();
  } on OutOfMemoryError {
    print(OutOfMemoryError);
    rethrow;
  } catch (e) {
    print(e);
  } finally {
    print('finally');
  }
```

11. 类
构造函数

命名构造函数,冒号后边可以初始化成员变量

重定向构造函数

12. 抽象
定义 类 成员 函数

不能直接 new

继承方式使用

接口方式使用

13. identical(),判断是否是同一个对象  