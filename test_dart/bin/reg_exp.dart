// 取 PPM 单位
String getUnit() {
  String input = "123.33ppm";
  RegExp regex = RegExp(r"[^0-9.]");
  Iterable<Match> matches = regex.allMatches(input);
  List<String> result = matches.map((match) => match.group(0)!).toList();
  String nonNumericNonDecimalString = result.join();
  return nonNumericNonDecimalString;
}

// 删除匹配到的元素
void deleteUnit(String str) {
  str = str.replaceAll(RegExp(r'[‰%‱\bPPM\b\bppm\b]'), '');
  print(str);
}

// 一定要注意这个 \-
List<String> splitExpression(String expression) {
  RegExp regex = RegExp(r'[+\-x÷]');

  List<String> result = expression.split(regex);

  return result;
}
