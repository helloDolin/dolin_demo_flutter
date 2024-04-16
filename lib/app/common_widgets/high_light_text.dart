import 'package:flutter/cupertino.dart';

/// 匹配高亮 Text
class HighlightText extends StatelessWidget {
  const HighlightText({
    required this.text,
    required this.regPattern,
    required this.textStyle,
    required this.highlightStyle,
    super.key,
    this.multiLine = false,
    this.caseSensitive = true,
    this.unicode = false,
    this.dotAll = false,
  });

  /// 文本
  final String text;

  /// 正则表达式
  final String regPattern;

  /// 文本样式
  final TextStyle textStyle;

  /// 关键字样式
  final TextStyle highlightStyle;

  final bool multiLine;
  final bool caseSensitive;
  final bool unicode;
  final bool dotAll;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: formSpan(text, regPattern),
    );
  }

  InlineSpan formSpan(String src, String pattern) {
    if (pattern.isEmpty || src.isEmpty) {
      return TextSpan(text: src, style: textStyle);
    }
    final List<TextSpan> span = [];
    // 使用正则表达式匹配
    RegExp regExp;
    try {
      regExp = RegExp(
        pattern,
        multiLine: multiLine,
        caseSensitive: caseSensitive,
        unicode: unicode,
        dotAll: dotAll,
      );
    } catch (e) {
      return TextSpan(text: src, style: textStyle);
    } // 此函数回调 match 和 nonMatch 完美😄
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
