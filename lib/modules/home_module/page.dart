import 'package:flutter/material.dart';
import 'package:flutter_getx_starterpack/data/models/profile/profile.dart';
import 'package:flutter_getx_starterpack/modules/home_module/controller.dart';
import 'package:flutter_getx_starterpack/modules/home_module/widgets/splash_home.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (_) {
          if (controller.profile.value is Data) {
            Data profile = controller.profile.value as Data;
            return Scaffold(
              body: Stack(
                children: [
                  SafeArea(
                    child: Container(
                      constraints: const BoxConstraints.expand(),
                      child: Text(profile.nickname!),
                    ),
                  )
                ],
              ),
            );
          }
          return const SplashHomeWidget();
        });
  }
}
