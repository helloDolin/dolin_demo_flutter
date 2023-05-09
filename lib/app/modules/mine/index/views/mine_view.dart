import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/user.dart';
import '../../../practice/webView.dart';
import '../controllers/mine_controller.dart';

class MineView extends GetView<MineController> {
  const MineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // 已登录
            _logined(),
            // 未登录
            _noLogin(),
            // TODO:两个分组完善，切换语言挪到这边
            // TODO：登录未登录显示 bugfix
            // 第一个分组
            _group1(),
            // 第二个分组
            _group2(),
          ],
        ),
      )),
    );
  }

  Container _group2() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.amberAccent),
        color: const Color(0xFF0B82F1).withAlpha(15),
        borderRadius: const BorderRadius.all(Radius.circular(2)),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.summarize),
            title: const Text("免责声明"),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onTap: () {
              controller.setTheme();
            },
          ),
          ListTile(
            leading: const Icon(Icons.flutter_dash),
            title: const Text("开源主页"),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onTap: () {
              controller.setTheme();
            },
          ),
        ],
      ),
    );
  }

  Container _group1() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.amberAccent),
        color: const Color(0xFF0B82F1).withAlpha(15),
        borderRadius: const BorderRadius.all(Radius.circular(2)),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.sunny),
            title: const Text("显示主题"),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onTap: () {
              controller.setTheme();
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("更多设置"),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onTap: () {
              controller.setTheme();
            },
          ),
        ],
      ),
    );
  }

  Obx _noLogin() {
    return Obx(() => Visibility(
        visible: !UserStore.to.isLogin.value,
        child: InkWell(
          onTap: () {
            controller.login();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  child: Image.network(
                    'https://avatars.githubusercontent.com/u/12538263?s=100&v=4',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "未登录",
                      style: TextStyle(height: 1.0),
                    ),
                    Text(
                      "点击前往登录",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        )));
  }

  Obx _logined() {
    return Obx(() => Visibility(
        visible: UserStore.to.isLogin.value,
        child: InkWell(
          onTap: () {
            Get.to(() => const WebView());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                  child: Image.network(
                    'https://avatars.githubusercontent.com/u/12538263?s=100&v=4',
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text.rich(TextSpan(
                    text: 'DOLIN',
                    style: TextStyle(fontSize: 20),
                    children: [
                      WidgetSpan(
                          child: Icon(
                        Icons.sports_basketball,
                        color: Colors.blueGrey,
                        size: 24,
                      )),
                    ])),
                const Spacer(),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        )));
  }
}
