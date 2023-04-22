import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SettingsView'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: const [
              Text(
                'SettingsView is working',
                style: TextStyle(fontSize: 20),
              ),
              Item(
                title: '123',
                subTitle: 'abc',
              ),
              Item(
                title: '123',
                subTitle: '',
              )
            ],
          ),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.DEVICE_INFO);
          },
          child: const Text('device info'),
        ));
  }
}

class Item extends StatelessWidget {
  const Item({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          const Icon(Icons.check_sharp),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(title), if (subTitle.isNotEmpty) Text(subTitle)],
          ),
        ],
      ),
    );
  }
}
