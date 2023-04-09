import 'package:dolin_demo_flutter/app/modules/user/views/arena_practice.dart';
import 'package:dolin_demo_flutter/app/modules/user/views/async_practice.dart';
import 'package:dolin_demo_flutter/app/modules/user/views/customer_paint_view.dart';
import 'package:dolin_demo_flutter/app/modules/user/views/pieces_of_knowledge.dart';
import 'package:dolin_demo_flutter/app/modules/user/views/radius_%20summary.dart';
import 'package:dolin_demo_flutter/app/modules/user/views/wechat_friends.dart';
import 'package:dolin_demo_flutter/app/util/screenAdapter.dart';
import 'package:dolin_demo_flutter/app/util/randomColor.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Card('手绘 Widget', () {
                Get.to(const CustomPaintPage());
              }),
              Card('手势竞技场', () {
                Get.to(const ArenaPage());
              }),
              Card('异步练习', () {
                Get.to(const AsyncPage());
              }),
              Card('小知识点总结', () {
                Get.to(const PiecesOfKnowledge());
              }),
              Card('各种圆角总结', () {
                Get.to(const RadiusSummary());
              }),
              Card('微信朋友圈', () {
                Get.to(const WechatFriends());
              }),
            ],
          )),
    );
  }
}

class Card extends StatelessWidget {
  const Card(this.title, this.onTap, {Key? key}) : super(key: key);
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          padding: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(
                color: getRandomColor(), width: ScreenAdapter.height(1)),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          height: 44,
          child: Text(title),
        ));
  }
}
