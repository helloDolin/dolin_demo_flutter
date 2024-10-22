Future<void> req1() async {
  await Future.delayed(Duration(seconds: 3), () => print('11111'));
}

Future<void> req2() async {
  // throw Exception('异常测试');
  await Future.delayed(Duration(seconds: 3), () => print('222222'));
}

void executeGroup() {
  Future.wait([
    req1(),
    req2(),
  ])
      .then((value) => print('😄😄😄😄'))
      .whenComplete(() => print('whenComplete'))
      .catchError((error) {
    print(error);
  });
}
