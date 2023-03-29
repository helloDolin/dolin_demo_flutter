import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  static double width(num v) {
    return v.w;
  }

  static double height(num v) {
    return v.h;
  }

  static double fontSize(num v) {
    return v.sp;
  }

  static double getScreenWidth() {
    // return ScreenUtil().screenWidth;
    return 1.sw;
  }

  static double getScreenHeight() {
    // return ScreenUtil().screenHeight;
    return 1.sh;
  }
}
