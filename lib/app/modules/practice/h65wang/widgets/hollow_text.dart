import 'package:flutter/material.dart';

class HollowText extends StatelessWidget {
  const HollowText({
    required this.text,
    required this.thickness,
    required this.color,
    required this.fontSize,
    super.key,
    this.hollowColor,
  });
  final String text;
  final Color color;
  final double fontSize;
  final double thickness;
  final Color? hollowColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = thickness
              ..color = color,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: hollowColor ?? Colors.transparent,
          ),
        )
      ],
    );
  }
}
