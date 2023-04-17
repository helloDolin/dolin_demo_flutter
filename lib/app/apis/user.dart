import 'package:dolin_demo_flutter/app/data/userModel.dart';
import 'package:dolin_demo_flutter/app/https/httpsClient.dart';

/// 用户
class UserAPI {
  /// 登录
  static Future<UserLoginResponseEntity> login({
    Map? params,
  }) async {
    var response = await HttpsClient().post(
      '/user/login',
      // data:params
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  /// Profile
  static Future<UserLoginResponseEntity> profile() async {
    var response = await HttpsClient().post(
      '/user/profile',
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  /// Logout
  static Future logout() async {
    return await HttpsClient().post(
      '/user/logout',
    );
  }
}
