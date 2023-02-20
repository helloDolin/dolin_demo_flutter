import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dolin_demo_flutter/pages/bloc_practice/ticker.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _duration = 60;

  StreamSubscription<int>? _tickerSubscription;

  // 后面的部分:称为"初始化列表.它是一个,分离的表达式列表,可以访问构造函数参数,
  // 并可以分配给实例字段,甚至是final实例字段.这对于使用计算值初始化最终字段很方便
  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<_TimerTicked>(_onTicked);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
  }

  // 重载close方法，当TimerBloc被关闭的时候能取消_tickerSubscription
  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  // 如果TimerBloc收到TimerStarted事件，它会发送一个带有开始时间的TimerRunInProgress状态。
  // 此外，如果已经打开了_tickerSubscription我们需要取消它释放内存
  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    // 监听_ticker.tick流并且在每个触发时间我们添加一个包含剩余时间的_TimerTicked事件
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(_TimerTicked(duration: duration)));
  }

  void _onTicked(_TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgress(event.duration)
          : const TimerRunComplete(),
    );
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  void _onResumed(TimerResumed resume, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }
}
