import 'package:flutter/material.dart';
import 'package:flutter_getx_starterpack/routes/app_pages.dart';
import 'package:flutter_getx_starterpack/values/input_decoration.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

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

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (_, isKeyboardVisibile) => Form(
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
                    onEditingComplete: controller.loginWithEmailAndPassword,
                    validator: (text) {
                      if (text!.isEmpty) return 'Password is required.';

                      if (text.length < 8) {
                        return 'Password must be more  or 8 character.';
                      }
                      return null;
                    },
                    decoration: inputDecorationStyleOne(
                        hint: 'Input your password',
                        label: 'Password',
                        icon: const Icon(Icons.lock))),
                if (!isKeyboardVisibile)
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: controller.forgotPassword,
                        child: SizedBox(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot your password ?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.grey.shade700),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 65,
                        width: context.width,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                            onPressed: controller.loginWithEmailAndPassword,
                            child: const Text(
                              'SIGN IN',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => Get.offAndToNamed(Routes.REGISTER),
                        child: SizedBox(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Dont have account yet ? Register.',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.grey.shade700),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
