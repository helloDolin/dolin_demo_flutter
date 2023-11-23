class CustomError implements Exception {
  CustomError({
    this.message = '',
    this.code = 0,
  });
  final int code;
  final String message;

  @override
  String toString() {
    if (message == '') return 'Exception';
    return 'Exception: code $code, $message';
  }
}
