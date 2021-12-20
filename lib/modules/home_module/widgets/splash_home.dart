import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashHomeWidget extends StatelessWidget {
  const SplashHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: Get.theme.primaryColor.withOpacity(.5),
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Hero(
            tag: 'airplane',
            child: Lottie.asset(
              'assets/lottiefiles/airplane.json',
            ),
          ),
        ),
      ),
    );
  }
}
