import 'package:flutter/cupertino.dart';

/// 关键字高亮 Text
class HighlightText extends StatelessWidget {
  const HighlightText({
    super.key,
    required this.text,
    required this.keyword,
    required this.textStyle,
    required this.highlightStyle,
  });

  /// 文本
  final String text;

  /// 关键字
  final String keyword;

  /// 文本样式
  final TextStyle textStyle;

  /// 关键字样式
  final TextStyle highlightStyle;

  @override
  Widget build(BuildContext context) {
    final RegExp regExp = RegExp(
      keyword,
      caseSensitive: false, // 不区分大小写
    );

    return RichText(
      text: TextSpan(
        children: _buildTextSpans(regExp),
      ),
    );
  }

  List<TextSpan> _buildTextSpans(
    RegExp regExp,
  ) {
    final List<TextSpan> spans = [];
    int? lastMatchEnd = 0;

    regExp.allMatches(text).forEach((match) {
      final beforeMatch = text.substring(lastMatchEnd!, match.start);
      if (beforeMatch.isNotEmpty) {
        spans.add(TextSpan(text: beforeMatch, style: textStyle));
      }

      final matchedText = text.substring(match.start, match.end);
      spans.add(TextSpan(text: matchedText, style: highlightStyle));

      lastMatchEnd = match.end;
    });

    final remainingText = text.substring(lastMatchEnd!);
    if (remainingText.isNotEmpty) {
      spans.add(TextSpan(text: remainingText, style: textStyle));
    }

    return spans;
  }
}
