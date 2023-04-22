import 'package:get/get.dart';

import '../modules/home/detail/bindings/detail_binding.dart';
import '../modules/home/detail/deatailMiddleWare.dart';
import '../modules/home/detail/views/detail_view.dart';
import '../modules/home/list/bindings/list_binding.dart';
import '../modules/home/list/views/list_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/settings/device_info/bindings/device_info_binding.dart';
import '../modules/settings/device_info/views/device_info_view.dart';
import '../modules/settings/device_info/watch_info/bindings/watch_info_binding.dart';
import '../modules/settings/device_info/watch_info/views/watch_info_view.dart';
import '../modules/settings/views/settings_view.dart';
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
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      children: [
        GetPage(
          name: _Paths.DEVICE_INFO,
          page: () => const DeviceInfoView(),
          binding: DeviceInfoBinding(),
          children: [
            GetPage(
              name: _Paths.WATCH_INFO,
              page: () => const WatchInfoView(),
              binding: WatchInfoBinding(),
            ),
          ],
        ),
      ],
    ),
  ];
}
