import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  String phoneNum = '';
  String password = '';
  final GlobalKey<FormState> formKey = GlobalKey();
}
