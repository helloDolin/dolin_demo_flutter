import 'package:dolin_demo_flutter/app/util/dialog_util.dart';
import 'package:dolin_demo_flutter/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
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
        border: Border.all(width: 0.5, color: Colors.cyan),
        color: const Color(0xFF0B82F1).withAlpha(15),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.summarize),
            title: Text(LocaleKeys.mine_disclaimer.tr),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onTap: () {
              DialogUtil.showStatement();
            },
          ),
          const Divider(height: 0.5),
          Obx(() => ListTile(
                leading: const Icon(Icons.language),
                title: Text(
                    '${LocaleKeys.mine_switch_language.tr} (${controller.curLanguage.value})'),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: () {
                  controller.changeLang();
                },
              )),
          const Divider(height: 0.5),
          ListTile(
            leading: const Icon(Icons.system_update),
            title: const Text("检查更新"),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onTap: controller.checkUpdate,
          ),
          const Divider(height: 0.5),
          ListTile(
            leading: const Icon(Icons.read_more),
            title: const Text("关于APP"),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onTap: controller.about,
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
        border: Border.all(width: 0.5, color: Colors.cyan),
        color: const Color(0xFF0B82F1).withAlpha(15),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.sunny),
            title: Text(LocaleKeys.mine_show_theme.tr),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onTap: () {
              controller.setTheme();
            },
          ),
          const Divider(height: 0.5),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(LocaleKeys.mine_more_setting.tr),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onTap: () {
              Get.toNamed(Routes.SETTINGS);
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
