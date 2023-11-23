import 'package:dolin/app/data/mine/userModel.dart';
import 'package:dolin/app/https/https_client.dart';

/// 用户
class UserAPI {
  /// 登录
  static Future<UserLoginResponseEntity> login({
    Map<String, dynamic>? params,
  }) async {
    final response = await HttpsClient().post(
      '/user/login',
      // data:params
    );
    return UserLoginResponseEntity.fromJson(response as Map<String, dynamic>);
  }

  /// Profile
  static Future<UserLoginResponseEntity> profile() async {
    final response = await HttpsClient().post(
      '/user/profile',
    );
    return UserLoginResponseEntity.fromJson(response as Map<String, dynamic>);
  }

  /// Logout
  static Future<void> logout() async {
    return HttpsClient().post(
      '/user/logout',
    );
  }
}
