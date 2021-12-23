import 'dart:async';

import 'package:flutter_getx_starterpack/data/models/channel/channel.dart'
    as channel_model;
import 'package:flutter_getx_starterpack/data/models/profile/profile.dart'
    as profile_model;
import 'package:flutter_getx_starterpack/data/repositories/channel_repository.dart';
import 'package:flutter_getx_starterpack/data/repositories/profile_repository.dart';
import 'package:flutter_getx_starterpack/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController(
      {ProfileRepository? repository, ChannelRepository? channelRepository})
      : _repository = repository ?? ProfileRepository(),
        _channelRepository = channelRepository ?? ChannelRepository() {
    _profileSubscribtion =
        _repository.streamUserProfile.listen((event) => getUserProfile(event));
  }

  late final StreamSubscription _profileSubscribtion;
  final ProfileRepository _repository;
  final ChannelRepository _channelRepository;

  Rx<profile_model.Profile> profile = const profile_model.Profile.empty().obs;
  List<channel_model.Channel> channels = [];

  void getUserProfile(profile_model.Profile userProfile) async {
    if (userProfile is profile_model.Empty) {
      Get.offAndToNamed(Routes.PROFILE_CREATE);
    }
    if (userProfile is profile_model.Data) {
      profile = userProfile.obs;
      _getUserChannels();
      update();
    }
  }

  void _getUserChannels() async {
    Get.log('data user channels');
    final myProfile = profile.value as profile_model.Data;
    if (myProfile.channels!.isNotEmpty) {
      List<channel_model.Channel> list =
          await _channelRepository.getUserChannel(list: myProfile.channels!);
      channels = list;
      update(['channels']);
    }
  }

  @override
  void dispose() {
    _profileSubscribtion.cancel();
    super.dispose();
  }
}
