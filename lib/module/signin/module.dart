import 'package:dolin_demo_flutter/util/app_module.dart';

class Module with AppModule {
  @override
  void onInit() {
    // FlutterPageRegistrar.registerPageBuilders({
    //   '/merchant/add_wechat/record': (pageName, params, _) => const Page(),
    // });
    print('注册模块 onInit');
  }

  @override
  void onRegister() {
    // registerModule(home.Module());
    // registerModule(record.Module());
    // registerModule(commit.Module());
    print('注册模块 onRegister');
  }
}
