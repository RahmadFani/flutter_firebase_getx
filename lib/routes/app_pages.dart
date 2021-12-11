import 'package:flutter_getx_starterpack/data/repositories/auth_repository.dart';
import 'package:flutter_getx_starterpack/modules/auth_register_module/controller.dart';
import 'package:flutter_getx_starterpack/modules/auth_register_module/page.dart';
import 'package:flutter_getx_starterpack/modules/home_module/page.dart';
import 'package:flutter_getx_starterpack/modules/auth_login_module/controller.dart';
import 'package:flutter_getx_starterpack/modules/auth_login_module/page.dart';
import 'package:flutter_getx_starterpack/modules/splash_screen_module.dart/page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      transition: Transition.fadeIn,
      page: () => const SplashScreenPage(),
    ),
    GetPage(
        name: Routes.LOGIN,
        transition: Transition.fadeIn,
        page: () => const LoginPage(),
        binding: BindingsBuilder.put(() => LoginController(AuthRepository()))),
    GetPage(
        name: Routes.REGISTER,
        transition: Transition.fadeIn,
        page: () => const RegisterPage(),
        binding: BindingsBuilder.put(() => RegisterController())),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
    )
  ];
}
