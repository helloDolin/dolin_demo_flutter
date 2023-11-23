import 'dart:convert';

import 'package:dolin/app/apis/mine/user.dart';
import 'package:dolin/app/data/mine/userModel.dart';
import 'package:dolin/app/services/storage_service.dart';
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
    final profileOffline = StorageService.instance.getValue('user_profile', '');
    if (profileOffline.isNotEmpty) {
      _profile(
        UserLoginResponseEntity.fromJson(
          jsonDecode(profileOffline) as Map<String, dynamic>,
        ),
      );
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
    final result = await UserAPI.profile();
    _profile(result);
    await StorageService.instance.setValue('user_profile', jsonEncode(result));
  }

  // 保存 profile
  Future<void> saveProfile(UserLoginResponseEntity profile) async {
    await StorageService.instance.setValue('user_profile', jsonEncode(profile));
  }

  // 注销
  Future<void> onLogout() async {
    if (isLogin.value) await UserAPI.logout();
    await StorageService.instance.removeValue<void>('user_token');
    isLogin.value = false;
    token = '';
  }
}
