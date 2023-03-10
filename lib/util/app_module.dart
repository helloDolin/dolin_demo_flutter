// import 'dart:async';

mixin AppModule {
  static final _modules = <Type, AppModule>{};
  Map<Type, AppModule> get modules => _modules;

  bool get isAsync => false;

  void onRegister() {}

  void onInit();
}

/// The function used to initialize the Module will call the
/// `OnInit` method of all Modules in the registration chain.
///
void initModules() {
  AppModule._modules.forEach((k, v) {
    if (v.isAsync) {
      Future.microtask(() => v.onInit());
    } else {
      v.onInit();
    }
  });
}

/// The function used to register the module will call the
/// `onRegister` method of `module`.
///
void registerModule(AppModule module) {
  if (!AppModule._modules.containsKey(module.runtimeType)) {
    AppModule._modules[module.runtimeType] = module;
    module.onRegister();
  }
}
