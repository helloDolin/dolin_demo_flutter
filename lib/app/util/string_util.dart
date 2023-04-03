// 邮箱判断
bool isEmail(String input) {
  String regexEmail =
      "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
  if (input.isEmpty) return false;
  return RegExp(regexEmail).hasMatch(input);
}
