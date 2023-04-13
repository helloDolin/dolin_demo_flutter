import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          'hello': '你好',
          'home': '首页',
          'category': '分类',
          'service': '服务',
          'cart': '购物车',
          'mine': '我的'
        },
        'de_DE': {
          'hello': 'HELLO',
        }
      };
}
