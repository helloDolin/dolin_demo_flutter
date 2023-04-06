import 'package:get/get.dart';

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
    ),
    GetPage(
        name: _Paths.SEARCH,
        page: () => const SearchView(),
        binding: SearchBinding(),
        transitionDuration: const Duration(milliseconds: 100),
        transition: Transition.fadeIn),
  ];
}
