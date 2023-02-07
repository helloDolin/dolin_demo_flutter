import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension NumExtension on num {
  double get rpx {
    debugPrint(ScreenUtil().screenWidth.toString());
    return ScreenUtil().screenWidth * this / 375;
  }
}
