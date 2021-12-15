import 'package:flutter/material.dart';

class SplashHomeWidget extends StatelessWidget {
  const SplashHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: const Center(
          child: Text('Loading'),
        ),
      ),
    );
  }
}
