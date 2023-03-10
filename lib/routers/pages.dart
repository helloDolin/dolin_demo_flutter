import 'package:dolin_demo_flutter/routers/names.dart';
import 'package:dolin_demo_flutter/routers/observers.dart';
import 'package:dolin_demo_flutter/pages/welcome/bindings.dart';
import 'package:dolin_demo_flutter/pages/welcome/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();

  static List<String> history = [];

  static final List<GetPage> routes = [
    // 免登陆
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
      middlewares: const [
        // RouteWelcomeMiddleware(priority: 1),
      ],
    ),
    // GetPage(
    //   name: AppRoutes.SIGN_IN,
    //   page: () => SignInPage(),
    //   binding: SignInBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.SIGN_UP,
    //   page: () => SignUpPage(),
    //   binding: SignUpBinding(),
    // ),

    // // 需要登录
    // GetPage(
    //   name: AppRoutes.Application,
    //   page: () => ApplicationPage(),
    //   binding: ApplicationBinding(),
    //   middlewares: [
    //     RouteAuthMiddleware(priority: 1),
    //   ],
    // ),

    // // 分类列表
    // GetPage(
    //   name: AppRoutes.Category,
    //   page: () => CategoryPage(),
    //   binding: CategoryBinding(),
    // ),
  ];
}
