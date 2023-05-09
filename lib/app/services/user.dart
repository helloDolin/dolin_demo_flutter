import 'dart:convert';

import 'package:dolin_demo_flutter/app/apis/user.dart';
import 'package:dolin_demo_flutter/app/data/userModel.dart';
import 'package:dolin_demo_flutter/app/services/storage_service.dart';
import 'package:get/get.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  RxBool isLogin = false.obs;
  // 令牌 token
  String token = '';
  // 用户 profile
  final _profile = UserLoginResponseEntity().obs;

  UserLoginResponseEntity get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.instance.getValue('user_token', '');
    isLogin.value = token.isNotEmpty;
    var profileOffline = StorageService.instance.getValue('user_profile', '');
    if (profileOffline.isNotEmpty) {
      _profile(UserLoginResponseEntity.fromJson(jsonDecode(profileOffline)));
    }
  }

  // 保存 token
  Future<void> setToken(String value) async {
    await StorageService.instance.setValue('user_token', value);
    token = value;
    isLogin.value = true;
  }

  // 获取 profile
  Future<void> getProfile() async {
    if (token.isEmpty) return;
    var result = await UserAPI.profile();
    _profile(result);
    StorageService.instance.setValue('user_profile', jsonEncode(result));
  }

  // 保存 profile
  Future<void> saveProfile(UserLoginResponseEntity profile) async {
    StorageService.instance.setValue('user_profile', jsonEncode(profile));
  }

  // 注销
  Future<void> onLogout() async {
    if (isLogin.value) await UserAPI.logout();
    await StorageService.instance.removeValue('user_token');
    isLogin.value = false;
    token = '';
  }
}
