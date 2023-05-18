import 'package:dolin/app/modules/debug/log/log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/user.dart';
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
          title: const Text('登录'),
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
                          // 将焦点给一个新值，相当于隐藏键盘
                          FocusScope.of(context).requestFocus(FocusNode());
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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => controller.phoneNum = value.trim(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: '手机',
                        icon: Icon(Icons.phone),
                        helperText: '请输入 11 位手机号',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '请输入正确的手机号码';
                        }
                        RegExp reg = RegExp(r'^1\d{10}$');
                        if (!reg.hasMatch(value)) {
                          return '请输入正确的手机号码';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value) => controller.password = value.trim(),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: '密码',
                        // hintText: '密码',
                        icon: Icon(Icons.password),
                        helperText: '请输入 6 位密码',
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.trim().length != 6) {
                            return '密码为 6 位数';
                          }
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SafeArea(
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shadowColor: MaterialStateProperty.all(Colors.black),
                        elevation: MaterialStateProperty.all(10),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(150)),
                        ),
                      ),
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          final token =
                              'username:${controller.phoneNum}_password:${controller.password}';
                          Log.i('toke: $token');
                          UserStore.to.setToken(token);
                          Get.back();
                        }
                      },
                      child: const Text('登录')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
