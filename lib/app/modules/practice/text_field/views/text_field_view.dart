import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/dl_appbar.dart';
import '../../../../common_widgets/dl_textfield.dart';
import '../../../../util/random_color_util.dart';
import '../controllers/text_field_controller.dart';

class TextFieldView extends GetView<TextFieldController> {
  const TextFieldView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      appBar: const DLAppBar(title: 'test'),
      body: ListView(
        children: [
          const Title('自定义 TextField'),
          Obx(() => SizedBox(
                width: double.infinity,
                height: 50,
                child: DLTextField(
                  maxLength: 10,
                  text: controller.inputText.value,
                  onChanged: (text) {
                    controller.inputText.value = text;
                  },
                ),
              )),
          const SizedBox(
            width: double.infinity,
            height: 50,
            child: DLTextField(
              maxLength: 10,
              text: '嘿嘿',
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 50,
            child: DLTextField(
              maxLength: 10,
              text: '',
            ),
          ),
          const Title('UI 信息'),
          Text(controller.uiInfo.value)
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
