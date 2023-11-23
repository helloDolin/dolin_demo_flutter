import 'package:dolin/app/common_widgets/code/high_light_code.dart';
import 'package:dolin/app/common_widgets/code/highlighter_style.dart';
import 'package:flutter/material.dart';

class CodeWidget extends StatelessWidget {
  const CodeWidget({
    required this.code,
    required this.style,
    super.key,
    this.fontSize = 13,
    this.fontFamily,
  });

  final String code;
  final HighlighterStyle style;
  final double fontSize;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    Widget codeWidget;
    try {
      codeWidget = RichText(
        text: TextSpan(
          style: TextStyle(fontSize: fontSize, fontFamily: fontFamily),
          children: <TextSpan>[CodeHighlighter(style: style).format(code)],
        ),
      );
    } catch (err) {
      debugPrint(err.toString());
      codeWidget = Text(code);
    }
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: style.backgroundColor ?? const Color(0xffF6F8FA),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: codeWidget,
      ),
    );
  }
}
