import 'dart:ui';

// FPS 计算
// onReportTimings 方法只有在有帧被绘制时才有数据回调，如果用户没有和 App 发生交互，界面状态没有变化时，是不会产生新的帧的。
// 考虑到单个帧的绘制时间差异较大，逐帧计算可能会产生数据跳跃，所以为了让 FPS 的计算更加平滑，我们需要保留最近 25 个 FrameTiming 用于求和计算

// 原始FPS回调
var orginalCallback;

const maxframes = 25;
final lastFrames = <FrameTiming>[];

// 基准 VSync 信号周期 （~/返回一个整数值的除法）
const frameInterval =
    const Duration(microseconds: Duration.microsecondsPerSecond ~/ 60);

void onReportTimings(List<FrameTiming> timings) {
  lastFrames.addAll(timings);
  if (lastFrames.length > maxframes) {
    lastFrames.removeRange(0, lastFrames.length - maxframes);
  }

  if (orginalCallback != null) {
    orginalCallback(timings);
  }
  print("fps : $fps");
}

double get fps {
  int sum = 0;
  for (FrameTiming timing in lastFrames) {
    int duration = timing.timestampInMicroseconds(FramePhase.rasterFinish) -
        timing.timestampInMicroseconds(FramePhase.buildStart);
    if (duration < frameInterval.inMicroseconds) {
      sum += 1;
    } else {
      int count = (duration / frameInterval.inMicroseconds).ceil();
      sum += count;
    }
  }
  // FPS = 60 * 实际渲染的帧数 / 本来应该在这个时间内渲染完成的帧数
  return 60 * lastFrames.length / sum;
}
