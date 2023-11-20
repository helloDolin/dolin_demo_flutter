import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StreamPractice extends StatefulWidget {
  const StreamPractice({super.key});

  @override
  State<StreamPractice> createState() => _StreamPracticeState();
}

class _StreamPracticeState extends State<StreamPractice> {
  Stream<String> getTime() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 10));
      DateTime dateTime = DateTime.now();
      debugPrint(dateTime.millisecond.toString());

      String timeStr =
          DateFormat('yyyy-MM-dd 😄 HH:mm:ss').format(DateTime.now());
      timeStr = '$timeStr-${dateTime.millisecond ~/ 10}';
      yield timeStr;
    }
  }

  // late Stream stream =
  //     Stream.periodic(const Duration(seconds: 1), (value) => value);

  // broadcast 广播的形式，可以多监听，但是没有缓存了
  // late StreamController streamController = StreamController.broadcast();
  late StreamController streamController = StreamController();

  @override
  void initState() {
    // streamController.stream.listen((event) {
    //   print(event);
    // });
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamPractice'),
      ),
      body: DefaultTextStyle(
        style: const TextStyle(fontSize: 50, color: Colors.black),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => streamController.sink.add(10),
                child: const Text('10'),
              ),
              ElevatedButton(
                onPressed: () => streamController.sink.add(1),
                child: const Text('1'),
              ),
              ElevatedButton(
                onPressed: () => streamController.sink.add('Hi'),
                child: const Text('Hi'),
              ),
              ElevatedButton(
                onPressed: () => streamController.sink.addError('opps'),
                child: const Text('Error'),
              ),
              ElevatedButton(
                onPressed: () => streamController.close(),
                child: const Text('close'),
              ),
              StreamBuilder(
                // stream: streamController.stream.map((event) => event * 2),
                // stream: streamController.stream.where((event) => event is int),
                // stream: streamController.stream.distinct(),
                stream: getTime(),

                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Text('没有数据流');
                    case ConnectionState.waiting:
                      return const Text('等待数据流');
                    // 与 FutureBuilder 不同的是，StreamBuilder 在 active 状态下才有 hasData、hasError，
                    // 因为 Steam 是持续的，Future 不持续
                    case ConnectionState.active:
                      if (snapshot.hasData) {
                        return Text(snapshot.data.toString());
                      }
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      break;
                    case ConnectionState.done:
                      return const Text('ConnectionState.done');
                  }

                  // throw 'will not happen';
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
