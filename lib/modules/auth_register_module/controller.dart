import 'package:flutter/cupertino.dart';
import 'package:flutter_getx_starterpack/data/repositories/auth_repository.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final AuthRepository _repository;
  RegisterController({AuthRepository? repository})
      : _repository = repository ?? AuthRepository();

  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController rePassword;

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  void registerWithEmailAndPassword() async {
    FocusScope.of(Get.overlayContext!).unfocus();
    if (!formState.currentState!.validate()) return;

    try {
      await _repository.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 2),
        message: e.toString(),
      ));
    }
  }

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
    rePassword = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    rePassword.dispose();
    super.dispose();
  }
}
