// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/comic/index/bindings/comic_binding.dart';
import '../modules/comic/index/views/comic_view.dart';
import '../modules/home/detail/deatail_middleware.dart';
import '../modules/home/detail/detail_view.dart';
import '../modules/home/index/bindings/home_binding.dart';
import '../modules/home/index/views/home_view.dart';
import '../modules/index/bindings/index_binding.dart';
import '../modules/index/views/index_view.dart';
import '../modules/mine/index/bindings/mine_binding.dart';
import '../modules/mine/index/views/mine_view.dart';
import '../modules/mine/login/bindings/login_binding.dart';
import '../modules/mine/login/views/login_view.dart';
import '../modules/mine/settings/bindings/settings_binding.dart';
import '../modules/mine/settings/views/settings_view.dart';
import '../modules/practice/index/bindings/practice_binding.dart';
import '../modules/practice/index/views/practice_view.dart';
import '../modules/practice/text_field/bindings/text_field_binding.dart';
import '../modules/practice/text_field/views/text_field_view.dart';
import '../modules/practice/time_keeping/bindings/time_keeping_binding.dart';
import '../modules/practice/time_keeping/views/time_keeping_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INDEX;

  static final routes = [
    GetPage(
      name: _Paths.INDEX,
      page: () => const IndexView(),
      binding: IndexBinding(),
    ),
    GetPage(
      name: _Paths.COMIC,
      page: () => const ComicView(),
      binding: ComicBinding(),
    ),
    GetPage(
      name: _Paths.PRACTICE,
      page: () => const PracticeView(),
      binding: PracticeBinding(),
      children: [
        GetPage(
          name: _Paths.TEXT_FIELD,
          page: () => const TextFieldView(),
          binding: TextFieldBinding(),
        ),
        GetPage(
          name: _Paths.TIME_KEEPING,
          page: () => const TimeKeepingView(),
          binding: TimeKeepingBinding(),
        ),
      ],
    ),
    GetPage(
        name: _Paths.MINE,
        page: () => const MineView(),
        binding: MineBinding(),
        children: [
          GetPage(
            name: _Paths.LOGIN,
            page: () => const LoginView(),
            binding: LoginBinding(),
          ),
          GetPage(
            name: _Paths.SETTINGS,
            page: () => const SettingsView(),
            binding: SettingsBinding(),
          ),
        ]),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.DETAIL,
          page: () => const DetailView(),
          middlewares: [DeatailMiddleWare()],
        ),
      ],
    ),
  ];
}
