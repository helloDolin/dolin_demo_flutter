import 'package:dolin/my_provider/box_model.dart';
import 'package:dolin/my_provider/my_provider.dart';
import 'package:flutter/material.dart';

class MyProviderPage extends StatelessWidget {
  const MyProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    BoxModel model = MyProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyProviderPage'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            model.size = model.size + 10;
          },
          child: Container(
            width: model.size,
            height: model.size,
            color: Colors.teal,
            child: const Column(
              children: [
                Text('click me!'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
