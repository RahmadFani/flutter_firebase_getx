import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_getx_starterpack/data/repositories/profile_repository.dart';
import 'package:flutter_getx_starterpack/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCreateController extends GetxController {
  final ProfileRepository _repository;
  ProfileCreateController({ProfileRepository? repository})
      : _repository = repository ?? ProfileRepository();

  late PageController pageController;
  late TextEditingController nickname;

  File? avatar;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    nickname = TextEditingController();
  }

  @override
  void dispose() {
    pageController.dispose();
    nickname.dispose();
    super.dispose();
  }

  void pickAvatar() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      avatar = File(image.path);
      update();
    }
  }

  void get continueWithAvatar async {
    try {
      await _repository.saveUserProfile(
          nickname: nickname.text, avatar: avatar);

      Get.offAndToNamed(Routes.HOME);
    } catch (e) {
      Get.log(e.toString());
      throw 'e';
    }
  }

  void get continueWithoutAvatar async {
    try {
      await _repository.saveUserProfile(nickname: nickname.text);
    } catch (e) {
      throw 'e';
    }
  }

  void get nextPage {
    pageController.nextPage(
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  void get previousPage {
    pageController.previousPage(
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  }
}
