import 'package:dolin_demo_flutter/pages/scrollView.dart';
import 'package:dolin_demo_flutter/util/app_module.dart';
import 'package:dolin_demo_flutter/routers/routes.dart';

class Module with AppModule {
  @override
  void onInit() {
    appRoutes['/scrollViewPage'] = (context) => const ScrollViewPage();
    print('登录模块 onInit');
  }

  @override
  void onRegister() {
    // registerModule(home.Module());
    // registerModule(record.Module());
    // registerModule(commit.Module());
    print('登录模块 onRegister');
  }
}
