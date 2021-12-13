import 'package:flutter_getx_starterpack/data/repositories/profile_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ProfileRepository _repository;
  HomeController({ProfileRepository? repository})
      : _repository = repository ?? ProfileRepository();
}
