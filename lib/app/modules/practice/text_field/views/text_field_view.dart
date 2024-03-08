import 'package:dolin/app/common_widgets/dl_appbar.dart';
import 'package:dolin/app/common_widgets/dl_textfield.dart';
import 'package:dolin/app/modules/practice/text_field/controllers/text_field_controller.dart';
import 'package:dolin/app/util/random_color_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldView extends GetView<TextFieldController> {
  const TextFieldView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      appBar: const DLAppBar(title: 'DLTextField'),
      body: ListView(
        children: [
          const Title('自定义 TextField -- 1'),
          DLTextField(
            maxLength: 10,
            text: controller.inputText.value,
            onChanged: (text) {
              controller.inputText.value = text;
            },
          ),
          const Title('自定义 TextField -- 2'),
          const SizedBox(
            width: double.infinity,
            height: 50,
            child: DLTextField(
              maxLength: 10,
              autofocus: true,
              text: '嘿嘿',
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 50,
            child: DLTextField(
              maxLength: 10,
            ),
          ),
          const Title('UI 信息'),
          Text(controller.uiInfo.value),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: getRandomColor(),
      padding: const EdgeInsets.all(10),
      child: Text(title),
    );
  }
}
