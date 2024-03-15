// 抽象类可以有构造函数，但是不能由自己调用
// 在Dart中，抽象类（abstract class）可以有构造函数，但是这些构造函数必须用于子类的初始化，并且不能直接实例化抽象类。
abstract class Animal {
  Animal() {
    print('Animal 构造');
  }
}

// 构造函数传入的参数，并非都为类的成员变量，因为可以有构造参数去拼成员属性初始化过程，如 ListView 的 delegate，方便使用者调用，屏蔽复杂过程
// 封装的便捷性、灵活性
class Humen extends Animal {
  Humen({int age = 18}) {
    print(age);
  }
}
