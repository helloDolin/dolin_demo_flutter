class Singleton {
  Singleton._internal() {
    print('Singleton 实例化');
  }

  factory Singleton() => _instance;

  static final Singleton _instance = Singleton._internal();

  static Singleton get instance => _instance;
}
