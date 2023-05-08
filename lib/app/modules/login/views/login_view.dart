import 'package:dolin_demo_flutter/app/services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          title: const Text('LoginView'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  // Get.offAllNamed('/tabs', arguments: {
                  //   'username': controller.username,
                  //   'password': controller.password,
                  // });
                  Get.back();
                },
                icon: const Icon(Icons.close))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  controller.username = value.trim();
                },
                decoration: InputDecoration(
                  icon: const Icon(Icons.people),
                  hintText:
                      controller.username.isEmpty ? '账号' : controller.username,
                ),
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  controller.password = value.trim();
                },
                decoration: InputDecoration(
                  icon: const Icon(Icons.password_outlined),
                  hintText:
                      controller.password.isEmpty ? '密码' : controller.password,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      final token =
                          'username:${controller.username}_password:${controller.password}';
                      UserStore.to.setToken(token);
                    },
                    child: const Text('登录')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
