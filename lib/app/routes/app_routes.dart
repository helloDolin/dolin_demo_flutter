part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const TABS = _Paths.TABS;
  static const SEARCH = _Paths.SEARCH;
  static const LIST = _Paths.LIST;
  static const DETAIL = _Paths.DETAIL;
  static const LOGIN = _Paths.LOGIN;
  static const SETTINGS = _Paths.SETTINGS;
  static const DEVICE_INFO = _Paths.SETTINGS + _Paths.DEVICE_INFO;
  static const WATCH_INFO =
      _Paths.SETTINGS + _Paths.DEVICE_INFO + _Paths.WATCH_INFO;
}

abstract class _Paths {
  _Paths._();
  static const TABS = '/tabs';
  static const SEARCH = '/search';
  static const LIST = '/list';
  static const LIST_ID = '/list/:id';
  static const DETAIL = '/detail';
  static const LOGIN = '/login';
  static const SETTINGS = '/settings';
  static const DEVICE_INFO = '/device-info';
  static const WATCH_INFO = '/watch-info';
}
