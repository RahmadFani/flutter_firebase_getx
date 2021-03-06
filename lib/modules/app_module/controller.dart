import 'dart:async';
import 'package:flutter_getx_starterpack/data/models/user/user.dart';
import 'package:flutter_getx_starterpack/data/repositories/auth_repository.dart';
import 'package:flutter_getx_starterpack/data/repositories/profile_repository.dart';
import 'package:flutter_getx_starterpack/routes/app_pages.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  Rx<User> currentUser = const User.empty().obs;

  final AuthRepository _repository;

  AppController(
      {required AuthRepository repository,
      ProfileRepository? profileRepository})
      : _repository = repository {
    /// adding subscription if u need stream auth
    _subscription = _repository.user.listen((event) {
      appUserChanged(event);
    });
  }

  late final StreamSubscription _subscription;

  void appUserChanged(User user) async {
    if (user is Empty) {
      Get.offAllNamed(Routes.LOGIN);
    } else if (user is Data) {
      currentUser = user.obs;
      Get.offAllNamed(Routes.HOME);
    }
  }

  void get userLoggedOut async {
    unawaited(_repository.loggedOut);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
