import 'dart:async';

import 'package:flutter_getx_starterpack/data/models/profile/profile.dart'
    as profile_model;
import 'package:flutter_getx_starterpack/data/models/user/user.dart';
import 'package:flutter_getx_starterpack/data/repositories/auth_repository.dart';
import 'package:flutter_getx_starterpack/data/repositories/profile_repository.dart';
import 'package:flutter_getx_starterpack/routes/app_pages.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  Rx<User> currentUser = const User.empty().obs;

  final AuthRepository _repository;
  final ProfileRepository _profileRepository;
  AppController(
      {required AuthRepository repository,
      ProfileRepository? profileRepository})
      : _repository = repository,
        _profileRepository = profileRepository ?? ProfileRepository() {
    /// adding subscription if u need stream auth
    _subscription = _repository.user.listen((event) {
      appUserChanged(event);
    });
  }

  late final StreamSubscription _subscription;

  void appUserChanged(User user) async {
    if (user is Empty) {
      Get.offAndToNamed(Routes.LOGIN);
    } else if (user is Data) {
      currentUser = user.obs;
      Get.log('test snapshot');
      profile_model.Profile profile = await _profileRepository.getUserProfile;
      if (profile is profile_model.Empty) {
        Get.offAndToNamed(Routes.PROFILE_CREATE);
      } else {
        Get.offAndToNamed(Routes.HOME);
      }
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
