import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/router_report.dart';

class Global {
  /// 路由控制
  static final RouteObserver<PageRoute> routerObserver =
      RouteObserver<PageRoute>();
}

/// 不使用Getx路由，也能很轻松回收各个页面的GetXController
class GetXRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    // 让当前的路由标定给GetX
    RouterReportManager.reportCurrentRoute(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    RouterReportManager.reportRouteDispose(route);
  }
}
