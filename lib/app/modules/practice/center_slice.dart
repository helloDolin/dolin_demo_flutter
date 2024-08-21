import 'package:flutter/material.dart';

class CenterSlice extends StatelessWidget {
  const CenterSlice({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const Text(
              '1x 图片资源，不指定大小，默认尺寸：40x40',
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'assets/images/border.png',
              fit: BoxFit.fill,
            ),
            const Spacer(),
            const Text(
              '1x 图片资源，指定大小，拉伸',
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'assets/images/border.png',
              fit: BoxFit.fill,
              width: 300,
              height: 60,
            ),
            const Spacer(),
            const Text(
              '1x 图片资源，指定大小，拉伸，使用 centerSlice 正确调整大小',
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'assets/images/border.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: 60,
              // centerSlice: Rect.fromLTRB(10, 10, 30, 30),
              centerSlice: const Rect.fromLTWH(10, 10, 20, 20),
            ),
            const Spacer(),
            const Text(
              '自动选取 2x 资源，资源大小是 80x80，但实际渲染以 40x40',
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'assets/images/border_multi.png',
              fit: BoxFit.fill,
            ),
            const Spacer(),
            const Text(
              '指定大小',
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'assets/images/border_multi.png',
              fit: BoxFit.fill,
              width: 300,
              height: 60,
            ),
            const Spacer(),
            Image.asset(
              'assets/images/moss_unselect_2.png',
              fit: BoxFit.fill,
              width: 180,
              height: 180,
              centerSlice: const Rect.fromLTWH(30, 30, 5, 5),
              color: Colors.red,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
