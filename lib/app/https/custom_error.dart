class CustomError implements Exception {
  final int code;
  final String message;
  CustomError({
    this.message = '',
    this.code = 0,
  });

  @override
  String toString() {
    if (message == "") return "Exception";
    return "Exception: code $code, $message";
  }
}
