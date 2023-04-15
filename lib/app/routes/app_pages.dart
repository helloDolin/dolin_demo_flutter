import 'package:dolin_demo_flutter/app/modules/home/detail/deatailMiddleWare.dart';
import 'package:get/get.dart';

import '../modules/home/detail/bindings/detail_binding.dart';
import '../modules/home/detail/views/detail_view.dart';
import '../modules/home/list/bindings/list_binding.dart';
import '../modules/home/list/views/list_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/tabs/bindings/tabs_binding.dart';
import '../modules/tabs/views/tabs_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.TABS;

  static final routes = [
    GetPage(
        name: _Paths.TABS,
        page: () => const TabsView(),
        binding: TabsBinding(),
        children: [
          GetPage(
              name: _Paths.LIST,
              page: () => const ListView(),
              binding: ListBinding(),
              children: [
                GetPage(
                    name: _Paths.DETAIL,
                    page: () => const DetailView(),
                    binding: DetailBinding(),
                    middlewares: [DeatailMiddleWare()]),
              ]),
          GetPage(
            name: _Paths.LIST_ID,
            page: () => const ListView(),
            binding: ListBinding(),
          ),
        ]),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
      transitionDuration: const Duration(milliseconds: 100),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transitionDuration: const Duration(milliseconds: 100),
    ),
  ];
}
