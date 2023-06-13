import 'package:flutter/material.dart';

class InCommonUseWidgetPage extends StatelessWidget {
  const InCommonUseWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('常用组件'),
      ),
      body: SafeArea(
          child: Wrap(
        direction: Axis.horizontal,
        spacing: 20,
        runSpacing: 20,
        textDirection: TextDirection.ltr,
        // verticalDirection: VerticalDirection.up,
        // runAlignment: WrapAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2 / 1,
            child: Container(
              alignment: Alignment.center,
              color: Colors.red,
              child: const Text('AspectRatio'),
            ),
          ),
          const Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            elevation: 20,
            margin: EdgeInsets.all(10),
            child: Text('Card'),
          ),
          // 新版本的 button，波纹效果从当前点击的位置开始
          // 老版本的 FlatButton，波纹效果先变色再开始
          SizedBox(
            width: 300,
            height: 300,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.color_lens),
              onPressed: () {},
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.green),
                backgroundColor: MaterialStateProperty.all(Colors.amber),
                shadowColor: MaterialStateProperty.all(Colors.red),
                elevation: MaterialStateProperty.all(10),
                padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(150)),
                ),
                side: MaterialStateProperty.all(const BorderSide(
                  width: 10,
                  style: BorderStyle.solid,
                  strokeAlign: -1,
                )),
              ),
              label: const Text('ElevatedButton'),
            ),
          ),
          TextButton.icon(
            icon: const Icon(Icons.send),
            onPressed: () {},
            label: const Text('TextButton'),
          ),
          OutlinedButton.icon(
            icon: const Icon(Icons.send),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              side: MaterialStateProperty.all(
                  const BorderSide(width: 5, color: Colors.red)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
            ),
            onPressed: () {},
            label: const Text('OutlinedButton'),
          ),
          IconButton(
            icon: const Icon(Icons.thumb_up),
            onPressed: () {
              print('IconButton');
            },
          )
        ],
      )),
    );
  }
}
