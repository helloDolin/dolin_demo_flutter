// ignore_for_file: file_names

import 'package:dolin_demo_flutter/pages/bloc_practice/bloc/timer_bloc.dart';
import 'package:dolin_demo_flutter/pages/bloc_practice/ticker.dart';
import 'package:dolin_demo_flutter/util/randomColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocPage extends StatelessWidget {
  const BlocPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('BlocPage123')),
        body: BlocProvider(
          create: (_) => TimerBloc(ticker: const Ticker()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              TimerText(),
              Actions(),
            ],
          ),
        ));
  }
}

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).toString().padLeft(2, '0');
    return Container(
        color: getRandomColor(),
        child: Text(
          '$minutesStr:$secondsStr',
          style: Theme.of(context).textTheme.displayLarge,
        ));
  }
}

class Actions extends StatelessWidget {
  const Actions({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      // buildWhen携带前一个bloc状态和当前的bloc状态，并且返回一个boolean值。
      // 如果buildWhen返回true，将调用带有state的builder并且重建组件。
      // 如果buildWhen返回false，带有state的builder将不会被调用并且不会被重建
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Container(
            color: getRandomColor(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (state is TimerInitial) ...[
                  FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    onPressed: () => context
                        .read<TimerBloc>()
                        .add(TimerStarted(duration: state.duration)),
                  ),
                ],
                if (state is TimerRunInProgress) ...[
                  FloatingActionButton(
                    child: const Icon(Icons.pause),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerPaused()),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                  ),
                ],
                if (state is TimerRunPause) ...[
                  FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerResumed()),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                  ),
                ],
                if (state is TimerRunComplete) ...[
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                  ),
                ]
              ],
            ));
      },
    );
  }
}
