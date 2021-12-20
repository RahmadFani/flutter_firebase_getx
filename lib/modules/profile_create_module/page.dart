import 'package:flutter/material.dart';
import 'package:flutter_getx_starterpack/global_widgets/text_form/cool_text_form.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_getx_starterpack/values/text_style.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'controller.dart';

class ProfileCreatePage extends StatelessWidget {
  const ProfileCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: context.isPhone
            ? const ProfileCreatePhone()
            : const ProfileCreateTab());
  }
}

class ProfileCreatePhone extends GetView<ProfileCreateController> {
  const ProfileCreatePhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor.withOpacity(.5),
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _bodyStarted,
          const ProfileCreateForm(),
          const ProfileCreateFormTwo()
        ],
      ),
    );
  }

  Widget get _bodyStarted => Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'airplane',
              child: LottieBuilder.asset(
                'assets/lottiefiles/airplane.json',
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text('Hi there,', style: headingOneText()),
            Text('Welcome to MicoApp',
                textAlign: TextAlign.center, style: headingOneText()),
            const SizedBox(
              height: 10,
            ),
            Text('Before begin the jurney, let me know about you.',
                textAlign: TextAlign.center,
                style: headingFiveText(color: Colors.white.withOpacity(.9))),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)))),
                  onPressed: () {
                    controller.nextPage;
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      );
}

class ProfileCreateTab extends GetView<ProfileCreateController> {
  const ProfileCreateTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class ProfileCreateForm extends GetView<ProfileCreateController> {
  const ProfileCreateForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
        builder: (_, isKeyboardVisibile) => Container(
              constraints: const BoxConstraints.expand(),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'So nice to meet you! What do your friends call you?',
                    textAlign: TextAlign.center,
                    style: headingFiveText(),
                  ),
                  Expanded(child: Container()),
                  CoolTextFormCustom(
                    controller: controller.nickname,
                    label: 'Your Nickname...',
                    textAlign: TextAlign.center,
                  ),
                  Expanded(child: Container()),
                  Visibility(
                    visible: !isKeyboardVisibile,
                    child: SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(35)))),
                          onPressed: controller.nickname.text.isEmpty
                              ? null
                              : () => controller.nextPage,
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          )),
                    ),
                  )
                ],
              ),
            ));
  }
}

class ProfileCreateFormTwo extends GetView<ProfileCreateController> {
  const ProfileCreateFormTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Stack(
          children: [
            Container(
                constraints: const BoxConstraints.expand(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Choose your avatar',
                      textAlign: TextAlign.center,
                      style: headingOneText(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: controller.pickAvatar,
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Stack(
                          children: [
                            controller.avatar == null
                                ? const Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 100,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius:
                                            BorderRadius.circular(80)),
                                    width: 150,
                                    height: 150,
                                    child: Image.file(controller.avatar!)),
                            const Positioned(
                                bottom: 0,
                                right: 15,
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 35,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.green.withOpacity(.5),
                                  spreadRadius: 0,
                                  blurRadius: 10)
                            ],
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(80)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                )),
            Positioned(
              top: 50,
              left: 30,
              child: InkWell(
                onTap: () => controller.previousPage,
                child: const Icon(
                  Icons.arrow_back,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
                bottom: 30,
                left: 30,
                right: 30,
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(35)))),
                          onPressed: controller.avatar == null
                              ? null
                              : () => controller.continueWithAvatar,
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => controller.continueWithoutAvatar,
                      child: SizedBox(
                        child: Text('I want change avatar later !',
                            textAlign: TextAlign.center,
                            style: headingFiveText(
                                color: Colors.white.withOpacity(.9))),
                      ),
                    ),
                  ],
                ))
          ],
        );
      },
    );
  }
}
