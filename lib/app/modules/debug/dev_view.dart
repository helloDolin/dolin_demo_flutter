import 'package:dolin/app/modules/debug/log/log_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

const double kBallWidth = 60.0;

late OverlayEntry _overlayEntry;
RxDouble offsetX = (ScreenUtil().screenWidth - kBallWidth).obs;
RxDouble offsetY = (ScreenUtil().screenHeight / 2).obs;

void insertDevView() {
  _overlayEntry = OverlayEntry(builder: (BuildContext context) {
    return AnimatedPositioned(
        top: offsetY.value,
        left: offsetX.value,
        duration: const Duration(seconds: 0),
        child: Draggable(
          onDragEnd: (details) {
            if (details.offset.dx < 0) {
              offsetX.value = 0.0;
            } else if (details.offset.dx >
                (ScreenUtil().screenWidth - kBallWidth)) {
              offsetX.value = ScreenUtil().screenWidth - kBallWidth;
            } else {
              offsetX.value = details.offset.dx;
            }

            if (details.offset.dy < ScreenUtil().statusBarHeight) {
              offsetY.value = ScreenUtil().statusBarHeight;
            } else if (details.offset.dy >
                ScreenUtil().screenHeight -
                    ScreenUtil().bottomBarHeight -
                    ScreenUtil().statusBarHeight) {
              offsetY.value = ScreenUtil().screenHeight -
                  ScreenUtil().bottomBarHeight -
                  ScreenUtil().statusBarHeight;
            } else {
              offsetY.value = details.offset.dy;
            }
          },
          childWhenDragging: const SizedBox.shrink(),
          feedback: const FloatBall(),
          child: const FloatBall(),
        ));
  });
  Overlay.of(Get.overlayContext!).insert(_overlayEntry);
}

class FloatBall extends StatelessWidget {
  const FloatBall({super.key});

  @override
  Widget build(BuildContext context) {
    // text 属于 Material 风格，不加的话，text 下面会有两条黄线
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.to(() => const LogView());
        },
        child: Container(
          alignment: Alignment.center,
          width: kBallWidth,
          height: kBallWidth,
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(kBallWidth / 2)),
              color: Colors.blue.withOpacity(0.5)),
          child: const Text(
            'log\ninfo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
