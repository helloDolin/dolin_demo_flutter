import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/user.dart';
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
                  Get.dialog(AlertDialog(
                    title: const Text('暂不登录'),
                    content: Container(
                      constraints: const BoxConstraints(
                        maxHeight: 400,
                        maxWidth: 500,
                      ),
                      child: const SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('确定暂不登录'),
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: (() => Get.back(result: false)),
                        child: const Text("取消"),
                      ),
                      TextButton(
                        onPressed: (() {
                          Get.back(result: true);
                          Get.back();
                        }),
                        child: const Text("确定"),
                      ),
                      // ...?actions,
                    ],
                  ));
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
