import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common_widgets/rate_textfield.dart';
import '../controllers/rate_textfield_controller.dart';

class RateTextfieldView extends GetView<RateTextfieldController> {
  const RateTextfieldView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RateTextfieldView'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                controller.inputText.value = '1236767';
              },
              child: const Text('inputText'))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RateTextField(
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
              child: RateTextField(
                maxLength: 10,
                text: '嘿嘿',
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 50,
              child: RateTextField(
                maxLength: 10,
                text: '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
