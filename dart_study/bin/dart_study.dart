void main(List<String> arguments) {
  // print('Hello world: ${dart_study.calculate()}!');
  // 生成数据
  var ls1 = List.generate(10, (index) => index);
  print(ls1);

  var ls2 = [];
  ls2
    ..add(1)
    ..add(2)
    ..add(3)
    ..addAll([4, 5, 6]);
  print(ls2);

  Set set1 = <String>{'1', '2', '3'};
  Set set2 = <String>{'2', '3', '4'};
  print(set1.intersection(set2).toList()); // 交集
  print(set1.union(set2).toList()); // 并集

  // throw FormatException('adfasdf');
  // throw OutOfMemoryError();
  // throw '123';
}
