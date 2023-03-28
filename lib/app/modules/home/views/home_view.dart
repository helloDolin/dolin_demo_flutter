import 'package:dolin_demo_flutter/app/service/iconFonts.dart';
import 'package:dolin_demo_flutter/app/service/keepAliveWrapper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        keepAlive: true,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: Obx(() => AppBar(
                  title: const Text(
                    'HomeView',
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                  // appbar 设置透明
                  backgroundColor:
                      Colors.white.withOpacity(controller.opcity.value),
                  elevation: 0,
                )),
          ),
          body: ListView(
            controller: controller.scrollController,
            children: [
              Container(
                color: Colors.red,
                child: const Icon(IconFonts.xiaomi),
              ),
              const ListTile(title: Text('1111111111')),
              const ListTile(title: Text('1111111111')),
              const ListTile(title: Text('1111111111')),
              const ListTile(title: Text('1111111111')),
              const ListTile(title: Text('1111111111')),
              const ListTile(title: Text('1111111111')),
              const ListTile(title: Text('1111111111')),
              const ListTile(title: Text('1111111111')),
              const ListTile(title: Text('1111111111')),
              const ListTile(title: Text('1111111111')),
              const ListTile(title: Text('22222222')),
              const ListTile(title: Text('22222222')),
              const ListTile(title: Text('22222222')),
              const ListTile(title: Text('22222222')),
              const ListTile(title: Text('22222222')),
              const ListTile(title: Text('333333')),
              const ListTile(title: Text('333333')),
              const ListTile(title: Text('333333')),
              const ListTile(title: Text('333333')),
              const ListTile(title: Text('333333'))
            ],
          ),
        ));
  }
}
