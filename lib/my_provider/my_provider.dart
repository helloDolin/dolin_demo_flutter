import 'package:flutter/material.dart';

// 类名后加 T，才能声明 T 的属性
class MyProvider<T extends Listenable> extends StatefulWidget {
  const MyProvider({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final T Function() create;

  @override
  State<MyProvider<T>> createState() => _MyProviderState<T>();

  static T of<T>(BuildContext context) {
    // _MyInheritedWidget 一定要带泛型，不带找不到此类型
    return context
        .dependOnInheritedWidgetOfExactType<_MyInheritedWidget<T>>()!
        .model;
  }
}

class _MyProviderState<T extends Listenable> extends State<MyProvider<T>> {
  late T _model;

  @override
  void initState() {
    super.initState();
    _model = widget.create();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _model,
      builder: (BuildContext context, Widget? child) {
        return _MyInheritedWidget(
          _model,
          child: widget.child,
        );
      },
    );
  }
}

class _MyInheritedWidget<T> extends InheritedWidget {
  const _MyInheritedWidget(this.model, {required super.child});
  final T model;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

extension MyProviderExt<T extends Listenable> on BuildContext {
  T watch() {
    return MyProvider.of<T>(this);
  }
}
