# 学习过程
* 见：学习最初在于观察和模仿，发挥主观能动性
* 识：学习先辈传承的知识
* 思：打牢基础
* 破：引发思考，给他一株火苗让其在黑暗中前行，去探索，而非生硬地灌输知识。给他太阳，让一切暴露于阳光之下，明面上的思想，总是别人的


# 理解 + 思考（重点）

# 应用开发
## 界面显示
* 状态数据
* 布局结构
* 动画
## 交互操作
* 手势
* 设备
## 逻辑处理
界面逻辑（eg：有数据、无数据、异常场景显示什么？）
业务逻辑（eg：下单后，库存需要变化）
触发更新（eg：购物车变化，订单也需要变化）

# 量
## 可变量
类型 变量名 = 初始值
## 不可变量
* 运行期 final
* 编译器常量 const
## 静态量
static
```dart
class Person {
    String name;
// 静态成员变量 的特点，它不依赖于具体对象，是 类本身的一种属性 ，更像是一种可能被修改的公共特性
    static String nation = "";

    Person(this.name);

    void say(){
    print("我叫$name,我是$nation人");
    }

    Person.nation = "唐朝";
    print(Person.nation); // 唐朝

    Person p0 =  Person("甲");
    Person p1 =  Person("乙");
    Person p2 =  Person("丙");
    p1.say(); // 我叫乙,我是唐朝人
    p2.say(); // 我叫丙,我是唐朝人
}
```

# 函数
## 函数的参数
* 多个参数
* 命名参数
* 带有默认值的参数
* 位置参数（强调顺序，eg：DateTime）

## 函数类型
通过 typedef 定义类型

方法签名

可以直接调，也可以通过 call() 调用

lambda 表达式即匿名函数

# 基本数据类型
## 基础型
* bool（true，false）
* num(double，int)
```dart
num b = 3.28;
b.abs(); 		// 绝对值 : 3.28
b.ceil(); 		// 向上取整: 4
b.floor(); 		// 向下取整: 3
b.round(); 		// 四舍五入取整: 3
b.truncate();   // 去除小数部位取整: 3
String v = b.toStringAsFixed(1)); //四舍五入，保留几位小数，返回字符串: 3.3

double result1 = double.parse("3.3");
int result2 = int.parse("10");
```
## 聚合型
* String
```dart
String name = 'toly1994';
print(name[4]); // 1
print(name[name.length - 1]); // 4
print(name.substring(4,name.length - 1 )); //199

String name = '  toly 1994 ';
name.trim();//toly空1994
name.trimLeft(); //toly空1994空 
name.trimRight();//空空toly空1994

String name = 'tolY1994 ';
name.toUpperCase();//TOLY1994
name.toLowerCase(); //toly1994 

String name = 'toly1994';
name.startsWith('T'); // 以XXX开始
name.endsWith('4');  // 以XXX结尾
name.contains('99'); // 包含XXX

String name = 'toly 1994';
name.replaceAll(' ','_'); //toly_1994
name.split(' '); //[toly, 1994]
```
* List
```dart
List<String> cnNumUnits = ['零', '壹', '贰', '叁', '肆', '伍', '六', '柒', '捌', '玖'];
cnNumUnits.add('拾');
cnNumUnits.add('佰');
cnNumUnits.addAll(['仟', '萬', '亿']);
cnNumUnits.insert(2, '点');
cnNumUnits.insertAll(2, ['横', '撇']);
print(cnNumUnits);

---->[打印结果]----
[零, 壹, 横, 撇, 点, 贰, 叁, 肆, 伍, 六, 柒, 捌, 玖, 拾, 佰, 仟, 萬, 亿]

cnNumUnits.removeAt(2);
cnNumUnits.removeAt(2);
cnNumUnits.remove('点');
print(cnNumUnits);

---->[打印结果]----
[零, 壹, 贰, 叁, 肆, 伍, 六, 柒, 捌, 玖, 拾, 佰, 仟, 萬, 亿]
```
* Map
```dart
List<String> cnNumUnits = ['零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖'];
Map<int,String> cnNumMap = cnNumUnits.asMap();
print(cnNumMap);
```
* Set
```dart
// 首先 List 和 Set 之间可以相互转化。我们前面知道，Set 中的元素是不重复的，所以如果 List 中有重复的元素，通过 toSet 方法转化为 Set 之后，可以去除重复元素，再把 Set 通过 toList 转化为 List ，就可以达到 去重 的需求
```

# OOP
面向对象编程，是基于 对象 间的相互协作，来解决问题的一种思考方式。面向对象处理问题的过程中，通过 类 对事物的 数据 和 行为 进行封装，可以让各类事物的职能逻辑更加 "紧凑"，不至于零散地分处各地。这无形中会增加代码结构的稳定性，使其更易维护和拓展

弊端：一方面 屏蔽细节 可以简化使用者的调用，但另一方面，也可能导致当创作者看不懂自己写的是什么，或创作者的离去，其他接盘侠难以胜任，就会成为 “幽灵代码” 。从而导致上层建筑的繁荣，而底层根基的从封装到封死。这和 微观世界规律 非常类似，当最底层的细节无法窥探，很多技术就会陷入瓶颈，这和 《三体》里智子锁死地球科技有些相像

## 命名构造
一个类中命名构造的个数不限，只需要通过 类名.构造名 就可以定义。通过指定名称也有更好的语义性，很容易知道这个构造是干嘛的，个人觉得比重载要优雅一些。

# 类与类之间的关系
## 依赖（use-a）
单向虚线箭头
```dart
class Drawable{
  void draw(Vec2 vec2){
    print("绘制向量(${vec2.x},${vec2.y})");
  }
}

class Vec2{
  double x;
  double y;
  
  Vec2(this.x, this.y);
}
```

## 关联（has-a）
相对于 依赖 而言，关系要会更强,单向实线箭头
另外，当两各类相互关联时，称 双向关联,用双向实线箭头 
```dart
class User{
  User(this.computer);
  Computer computer;
  
  void pressStartButton(){
    computer.open();
  }
}

class Computer{
  Computer(this.name);
  String name;
  
  void open(){
    print("====电脑开机:[${name}]=====");
  }
}
```
## 聚合（has-a）
聚合 是一种 耦合性 更强的 关联关系 。一般 关联关系 的两个类 ，是相互独立的，在地位上平等。而 聚合关系 在语义上有 包含 的涵义，更强调 整体/个体 的区别。比如说，对于电脑而言，和 显卡 、内存 等硬件间这就是一种 聚合关系 。 我们一般通过如下的空心菱形实线箭头表示这种关系，菱形指向 整体类，箭头指向 个体类。

## 组合（has-a）
组合是一种 耦合性 比 聚合 更强的 关联关系 。它同样强调 整体/个体间的关系，但要求 整体 与 个体 不可分割。这个 不可分割 体现在 个体 的生命周期被 整体 控制，整体 对象的消亡，也会导致 个体 的消亡。

比如 学生 和 档案 之间的关系，随着 学生 学习阶段的变化，档案信息会随之变化。当学生死亡时，它的档案也就没有意义了。 我们一般通过如下的实心菱形实线箭头表示这种关系，菱形指向 整体类，箭头指向 个体类。从实心和空心上也能感受到 组合 的关系更为紧密。


## 继承（is-a）
单向实线三角空心箭头

## 实现
单向虚线三角空心箭头

## 抽象类与继承
抽象类中可以调用暂时不知道怎么实现的方法，这有助于整体逻辑的搭建，将具体的细节延迟到派生类中实现
```dart
abstract class Shape{
  Vec2 center;

  Shape(this.center);

  void move(){
    center.x += 10;
    center.y += 10;
  }

  void draw(){
    String info = "绘制矩形，中心点(${center.x},${center.y})"
        "${drawInChild()}";
    print(info);
  }

  String drawInChild(); // dart

  void rotate(){

  }
}
```
继承自抽象类，派生类必须实现其中的抽象方法 ，这是语法级别的 铁律

只有封装，才能产生类；只有存在类，才能说类与类间的关系，继承才有意义；只有存在 继承 体系，才能有多态的概念。这三者是环环相扣，不可逆序的。

封装 是 继承 的基础、继承 是 多态 的前提、而 多态 丰富 封装 的内容。这三者不是相互独立的，而是彼此依存，共同作用的

## 抽象类
特点：
* 抽象类【不允许】被直接实例化
```dart
// 有些抽象类似乎可以调用构造方法进行实例化
// 其实这只是个语法糖，对于抽象类来说，可以通过 factory 关键字定义 工厂构造方法 。在方法体中返回的依然是 派生类 对象，比如下面 Exception 工厂构造中返回的是 _Exception 对象：
abstract class Exception {
  factory Exception([var message]) => _Exception(message);
}

Exception exception = Exception("hello");
print(exception.runtimeType); // _Exception
```
* 抽象类中【允许】只声明成员方法，不进行实现

通过 抽象方法 来实现逻辑中的 求同存异 ，通用的逻辑在基类中完成，在派生中需要灵活处理的逻辑使用抽象方法，交由派生类实现。这就能将 变化 通过 抽象 进行隔离，是类设计中最常见的形式之一

## 接口
接口就是为了解决多继承二义性的问题，而引入的概念，这就是它存在的意义

Dart 对 implements 关键字的功能加强，迫使派生类必须提供 所有 成员变量的 get 方法，必须覆写 所有 成员方法。这样就可以让 类 和 接口 成为两个独立的概念，一个 class 既可以是类，也可以是接口，具有双重身份。其区别在于，在 extend 关键字后，表示继承，是作为类来对待；在 implements 关键字之后，表示实现，是作为接口来对待。

对于继承来说，派生类只需要实现抽象方法即可，抽象基类 中的普通成员方法可以不覆写

## Mixin
* 继承 、实现 之外的另一种 is-a 关系的维护方式
* 混入类不能拥有【构造方法】
* 当存在二义性问题时，会 “后来居上”
* 两个混入类间可以通过 on 关键字产生类似于 继承 的关系
* 混入类并非仅由mixin 声明，一切满足 没有构造方法 的类都可以作为混入类

混入类支持 抽象方法 ，而且同样要求派生类必须实现 抽象方法


抽象类 、接口 、混入类 都具有不能直接实例化的特点

## 零碎知识点
* 对象的类型判定和转化 is as
* 泛型：通过 extends 关键字来指定 T 的类型范围
* 空安全的本质变化是 null 从 Object 类族中脱离
* .. 可以实现连续的调用
* ... 用于解构可迭代对象
```dart
// eg:1 在 Column 中，通过 ...解构一个 Column
// eg:2
List<int> list = [0, 1, 2, 3, 4];
List<int> list2 = [6, ...list, 7];
print(list2); // [6, 0, 1, 2, 3, 4, 7]
```
* Stream
```dart
// 如果说 Future 对象是一件异步任务，那么 Stream 则是一系列的异步任务
```

