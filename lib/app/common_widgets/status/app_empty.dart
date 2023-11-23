import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({this.onRefresh, super.key});
  final void Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          onRefresh?.call();
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset(
                'assets/lotties/empty.json',
                width: 200,
                height: 200,
                repeat: false,
              ),
              const Text(
                '这里什么都没有',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
