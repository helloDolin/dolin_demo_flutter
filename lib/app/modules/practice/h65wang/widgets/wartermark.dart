import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class Watermark extends StatelessWidget {
  const Watermark({
    required this.child,
    required this.watermarkContent,
    super.key,
    this.contentTextStyle,
  });

  final Widget child;
  final String watermarkContent;
  final TextStyle? contentTextStyle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: child,
        ),
        // LayoutBuilder(
        //   builder:
        //       (BuildContext context, BoxConstraints constraints) {
        //     return Center(
        //       child: SizedBox(
        //         width: constraints.biggest.shortestSide,
        //         height: constraints.biggest.shortestSide,
        //         child: Transform.rotate(
        //           angle: -math.pi / 4,
        //           child: const FittedBox(
        //             child: Text('阿基德射流风机阿克苏登记了发卡机'),
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
        Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: FittedBox(
                child: Text(
                  watermarkContent,
                  style: contentTextStyle ??
                      TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
