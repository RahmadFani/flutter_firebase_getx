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

  Future<void> get register async {
    try {
      await _repository.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
    } catch (e) {
      throw e.toString();
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
