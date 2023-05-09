import 'package:dolin_demo_flutter/app/util/random_color_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/dl_appbar.dart';
import '../../../../common_widgets/dl_textfield.dart';
import '../controllers/rate_textfield_controller.dart';

class RateTextfieldView extends GetView<RateTextfieldController> {
  const RateTextfieldView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      appBar: const DLAppBar(),
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

          // 表单
          const SizedBox(
            height: 50,
          ),
          const Title('表单验证'),

          Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    // hintText: '电话',
                    labelText: '电话 label',
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
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(hintText: '用户名'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '请输入用户名';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          const Title('UI 信息'),

          Text(controller.uiInfo.value)
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.amber),
          ),
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              print('valid pass');
            }
          },
          child: const Text('验证表单是否通过'),
        ),
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
