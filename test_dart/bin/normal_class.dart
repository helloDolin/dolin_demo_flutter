// 测试属性声明时直接赋值，在 Student 初始化时，属性自然有值，解惑 State 初始化时
class Student with Play {
  String name = 'dolin';
  int age = 18;

  @override
  String playName() {
    return '@override playName() excute';
  }

  @override
  String toString() {
    return '$name,$age';
  }
}

mixin Play {
  void basketball() {
    print('play basketball');
  }

  String playName();
}

/// 常规类
// 先 with RespiratorySystem 原因：你必须依赖我依赖的
class Human with RespiratorySystem, MotorSystem {
  Human() {
    initInstances();
  }

  bool get alive => oxygen > 0;
}

/// 呼吸系统 mixin
mixin RespiratorySystem {
  int oxygen = 0; // 氧气量
  int _inhaleCount = 0; // 吸入量
  void initInstances({int count = 10}) {
    oxygen = 10;
    _inhaleCount = count;
    print('RespiratorySystem ========初始化:$oxygen========');
  }

  void inhale() {
    oxygen += 10;
    print('========呼吸系统吸入10点氧气值===氧气值:$oxygen========');
  }

  void run() {
    oxygen--;
    print('========呼吸系统正常运行===氧气值:$oxygen======');
  }
}

/// 运动系统 mixin
// MotorSystem 要使用 RespiratorySystem 的功能
mixin MotorSystem on RespiratorySystem {
  int _cost = 0; // 每次消耗的氧气量

  @override
  void initInstances({int count = 3}) {
    super.initInstances(count: count);
    _cost = _cost;
    print('MotorSystem ========初始化【运动系统】完成=========');
  }

  @override
  void run() {
    print('========运动系统运行=======');
  }
}
