import 'package:dolin/app/modules/mine/index/controllers/mine_controller.dart';
import 'package:dolin/app/routes/app_pages.dart';
import 'package:dolin/app/services/user.dart';
import 'package:dolin/app/util/dialog_util.dart';
import 'package:dolin/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

class MineView extends GetView<MineController> {
  const MineView({super.key});
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
        ),
      ),
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
            onTap: DialogUtil.showStatement,
          ),
          const Divider(height: 0.5),
          Obx(
            () => ListTile(
              leading: const Icon(Icons.language),
              title: Text(
                '${LocaleKeys.mine_switch_language.tr}'
                '(${controller.curLanguage.value})',
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              onTap: () {
                controller.changeLang();
              },
            ),
          ),
          const Divider(height: 0.5),
          ListTile(
            leading: const Icon(Icons.system_update),
            title: Text(LocaleKeys.mine_check_update.tr),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onTap: controller.checkUpdate,
          ),
          const Divider(height: 0.5),
          ListTile(
            leading: const Icon(Icons.read_more),
            title: Text(LocaleKeys.mine_about_app.tr),
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

  Widget _group1() {
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              if (!controller.guideShowed) {
                ShowCaseWidget.of(context).startShowCase([
                  controller.key1,
                  controller.key2,
                ]);
                controller.guideShowed = true;
              }
            },
          );
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
                Showcase(
                  key: controller.key1,
                  // title: 'Menu',
                  description: '点击这里切换主题',
                  child: ListTile(
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
                ),
                const Divider(height: 0.5),
                Showcase(
                  key: controller.key2,
                  title: '设置',
                  description: '点击这里切进行设置',
                  child: ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(LocaleKeys.mine_more_setting.tr),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Get.toNamed<void>(Routes.SETTINGS);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Obx _noLogin() {
    return Obx(
      () => Visibility(
        visible: !UserStore.to.isLogin.value,
        child: InkWell(
          onTap: () {
            controller.login();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 100,
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
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '未登录',
                        style: TextStyle(height: 1),
                      ),
                      Text(
                        '点击前往登录',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Obx _logined() {
    return Obx(
      () => Visibility(
        visible: UserStore.to.isLogin.value,
        child: InkWell(
          onTap: () {
            // Get.to<void>(() => const FlutterInappwebview());
          },
          child: SizedBox(
            height: 100,
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
                  const Text.rich(
                    TextSpan(
                      text: 'DOLIN',
                      style: TextStyle(fontSize: 20),
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.sports_basketball,
                            color: Colors.blueGrey,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
