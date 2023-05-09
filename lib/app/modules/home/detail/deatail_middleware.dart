import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../services/user.dart';

class DeatailMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // 登录时返回 null，正常跳转
    if (UserStore.to.isLogin || route == Routes.LOGIN) {
      return null;
    }
    // 未登录时跳登录页面
    return const RouteSettings(name: Routes.LOGIN);
  }
}
