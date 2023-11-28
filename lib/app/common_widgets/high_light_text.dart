import 'package:flutter/cupertino.dart';

/// 匹配高亮 Text
class HighlightText extends StatelessWidget {
  const HighlightText({
    required this.text,
    required this.pattern,
    required this.textStyle,
    required this.highlightStyle,
    super.key,
  });

  /// 文本
  final String text;

  /// 关键字
  final String pattern;

  /// 文本样式
  final TextStyle textStyle;

  /// 关键字样式
  final TextStyle highlightStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: formSpan(text, pattern),
    );
  }

  InlineSpan formSpan(String src, String pattern) {
    final List<TextSpan> span = [];
    // 使用正则表达式匹配
    final RegExp regExp = RegExp(pattern);
    // 此函数回调 match 和 nonMatch 完美😄
    src.splitMapJoin(
      regExp,
      onMatch: (Match match) {
        final String value = match.group(0) ?? '';
        span.add(TextSpan(text: value, style: highlightStyle));
        return '';
      },
      onNonMatch: (str) {
        span.add(TextSpan(text: str, style: textStyle));
        return '';
      },
    );
    return TextSpan(children: span);
  }
}
