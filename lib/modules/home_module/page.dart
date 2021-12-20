import 'package:flutter/material.dart';
import 'package:flutter_getx_starterpack/data/models/profile/profile.dart';
import 'package:flutter_getx_starterpack/modules/home_module/controller.dart';
import 'package:flutter_getx_starterpack/modules/home_module/widgets/splash_home.dart';
import 'package:flutter_getx_starterpack/routes/app_pages.dart';
import 'package:flutter_getx_starterpack/values/text_style.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
                  ),
                  if (profile.channels!.isEmpty)
                    SafeArea(
                        child: Container(
                      color: Colors.white,
                      constraints: const BoxConstraints.expand(),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Hi, ${profile.nickname!}',
                            textAlign: TextAlign.center,
                            style:
                                headingOneText(color: Get.theme.primaryColor),
                          ),
                          Text(
                            'Choose your server',
                            textAlign: TextAlign.center,
                            style:
                                headingOneText(color: Get.theme.primaryColor),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Lottie.asset('assets/lottiefiles/world_green.json',
                              width: 180, height: 180),
                          const SizedBox(
                            height: 35,
                          ),
                          SizedBox(
                            height: 65,
                            width: context.width,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Get.theme.primaryColor),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)))),
                                onPressed: () {},
                                child: const Text(
                                  'JOIN SERVER',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 65,
                            width: context.width,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)))),
                                onPressed: () =>
                                    Get.toNamed(Routes.CHANNEL_CREATE),
                                child: Text(
                                  'CREATE SERVER',
                                  style: TextStyle(
                                      color: Get.theme.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                          ),
                        ],
                      ),
                    ))
                ],
              ),
            );
          }
          return const SplashHomeWidget();
        });
  }
}
