import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_getx_starterpack/data/repositories/profile_repository.dart';
import 'package:get/get.dart';

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

  void get nextPage {
    pageController.nextPage(
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  void get previousPage {
    pageController.previousPage(
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  }
}
