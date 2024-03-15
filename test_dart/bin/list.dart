void test_list() {
  List<int> testArr = [5, 6, 7, 8, 9, 10];
  print(testArr.reduce((value, element) => value + element));
  print(testArr.fold<int>(10, (pre, cur) => pre + cur));
  print(testArr.any((element) => element >= 10));
  print(testArr.every((element) => element >= 9));
}
