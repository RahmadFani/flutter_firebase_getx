import 'package:flutter/material.dart';
import 'package:flutter_getx_starterpack/data/repositories/auth_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthRepository repository;
  LoginController(this.repository);

  late TextEditingController email;
  late TextEditingController password;

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
  }

  void loginWithEmailAndPassword() async {
    FocusScope.of(Get.overlayContext!).unfocus();
    if (!formState.currentState!.validate()) return;

    try {
      await repository.loginWithEmailAndPassword(
          email: email.text, password: password.text);
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 2),
        message: e.toString(),
      ));
    }
  }

  void forgotPassword() {}

  @override
  void dispose() {
    email.dispose();
    password.dispose();

    super.dispose();
  }
}
