import 'package:flutter_getx_starterpack/data/models/profile/profile.dart';
import 'package:flutter_getx_starterpack/data/repositories/profile_repository.dart';
import 'package:flutter_getx_starterpack/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ProfileRepository _repository;
  HomeController({ProfileRepository? repository})
      : _repository = repository ?? ProfileRepository() {
    getUserProfile();
  }

  Rx<Profile> profile = const Profile.empty().obs;

  void getUserProfile() async {
    try {
      final Profile userProfile = await _repository.getUserProfile;
      if (userProfile is Empty) {
        Get.offAndToNamed(Routes.PROFILE_CREATE);
      }
      if (userProfile is Data) {
        profile = userProfile.obs;
      }
    } catch (e) {
      throw 'Error';
    } finally {
      update();
    }
  }
}
