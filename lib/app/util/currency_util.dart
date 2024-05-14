// 格式化货币
import 'package:intl/intl.dart';

String formatCurrency(num amount) {
  if (amount % 1 == 0) {
    // 如果是整数，直接格式化为带逗号的整数
    return NumberFormat('#,##0', 'en_US').format(amount);
  } else {
    // 如果是小数，格式化为带逗号的带两位小数的数字
    return NumberFormat('#,##0.00', 'en_US').format(amount);
  }
}
