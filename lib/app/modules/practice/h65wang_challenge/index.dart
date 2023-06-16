import 'package:flutter/material.dart';

import 'widgets/corner_mark.dart';
import 'widgets/diagonal.dart';
import 'widgets/hollow_text.dart';
import 'widgets/wartermark.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('王叔不秃挑战')),
      body: Center(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return SingleChildScrollView(
              child: Flex(
                direction: orientation == Orientation.portrait
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  const HollowText(
                    text: '你好',
                    color: Colors.red,
                    fontSize: 50,
                    thickness: 3,
                    hollowColor: Colors.white,
                  ),
                  CornerMark(
                    markBgColor: Colors.red[200]!,
                    markTitleColor: Colors.white,
                    markTitle: '哈哈哈',
                    markTitleSize: 12,
                    child: Container(
                      width: 200,
                      height: 100,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(
                    width: 300,
                    height: 200,
                    child: Watermark(
                      watermarkContent: '绝密',
                      child: FlutterLogo(
                        style: FlutterLogoStyle.horizontal,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.blue[100],
                    child: ClipRRect(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Diagonal(
                          children: [
                            const FlutterLogo(
                              size: 100,
                            ),
                            const Text('123123123'),
                            Container(
                              width: 100,
                              height: 200,
                              color: Colors.red,
                            ),
                            const FlutterLogo(
                              size: 30,
                            ),
                            Container(
                              width: 10,
                              height: 100,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
