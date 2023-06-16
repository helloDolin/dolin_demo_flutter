import 'package:flutter/material.dart';

class Diagonal extends StatelessWidget {
  const Diagonal({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: MyDelegate(),
      children: [
        for (int i = 0; i < children.length; i++)
          LayoutId(id: i, child: children[i])
      ],
    );
  }
}

class MyDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    Offset offset = Offset.zero;
    for (int i = 0;; i++) {
      if (hasChild(i)) {
        final Size childSize = layoutChild(i, BoxConstraints.loose(size));
        positionChild(i, offset);
        offset += Offset(childSize.width, childSize.height);
      } else {
        break;
      }
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
