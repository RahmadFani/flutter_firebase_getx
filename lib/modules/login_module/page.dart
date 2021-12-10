import 'package:flutter/material.dart';
import 'package:flutter_getx_starterpack/values/input_decoration.dart';
import 'package:get/get.dart';

import 'controller.dart';

//GetView<LoginController>

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: context.isPhone ? oneColumn : twoColumn));
  }

  Widget get oneColumn => const LoginForm();

  Widget get twoColumn => Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.all(50),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                color: Get.theme.primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Hello, Friend!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Enter your personal account and start jurney with us.',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )),
              const Expanded(child: LoginForm())
            ],
          ),
        ),
      );
}

class LoginForm extends GetView<LoginController> {
  const LoginForm({Key? key}) : super(key: key);

  void _loginWithEmailAndPassword() async {
    FocusScope.of(Get.overlayContext!).unfocus();
    if (!controller.formState.currentState!.validate()) return;
    try {
      await controller.loginWithEmailAndPassword;
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 2),
        message: e.toString(),
      ));
    }
  }

  void _forgotPassword() {}

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formState,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: TextStyle(
                    color: Get.theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
              const SizedBox(
                height: 20,
              ),
              context.isPhone
                  ? Text(
                      'Enter your personal account and start jurney with us.',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(color: Colors.grey.shade600),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: controller.email,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text) {
                  if (text!.isEmpty) return 'Email is required.';

                  if (!GetUtils.isEmail(text)) return 'Email is invalid.';
                  return null;
                },
                decoration: inputDecorationStyleOne(
                    hint: 'Input your email',
                    label: 'Email',
                    icon: const Icon(Icons.email)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: controller.password,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onEditingComplete: _loginWithEmailAndPassword,
                  validator: (text) {
                    if (text!.isEmpty) return 'Password is required.';

                    if (text.length < 8) {
                      return 'Password must be more or 8 character.';
                    }
                    return null;
                  },
                  decoration: inputDecorationStyleOne(
                      hint: 'Input your password',
                      label: 'Password',
                      icon: const Icon(Icons.lock))),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: _forgotPassword,
                child: const SizedBox(
                  child: Text(
                    'Forgot your password ?',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 65,
                width: context.width * .5,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
                    onPressed: _loginWithEmailAndPassword,
                    child: const Text(
                      'SIGN IN',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
