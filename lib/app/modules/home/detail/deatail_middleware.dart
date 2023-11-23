import 'package:dolin/app/routes/app_pages.dart';
import 'package:dolin/app/services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeatailMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // 登录时返回 null，正常跳转
    if (UserStore.to.isLogin.value || route == Routes.LOGIN) {
      return null;
    }
    // 未登录时跳登录页面
    return const RouteSettings(name: Routes.LOGIN);
  }
}
