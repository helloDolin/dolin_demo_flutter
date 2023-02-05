import 'package:flutter_screenutil/flutter_screenutil.dart';

extension NumExtension on num {
  double get rpx {
    print(ScreenUtil().screenWidth);
    return ScreenUtil().screenWidth * this / 375;
  }
}
