import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoaddingWidget extends StatelessWidget {
  const AppLoaddingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: LottieBuilder.asset(
          'assets/lotties/loadding.json',
          width: 200,
        ),
      ),
    );
  }
}
