import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_getx_starterpack/data/repositories/channel_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChannelCreateController extends GetxController {
  final ChannelRepository _channelRepository;
  ChannelCreateController({ChannelRepository? channelRepository})
      : _channelRepository = channelRepository ?? ChannelRepository();

  late PageController pageController;

  String typeServer = '';
  late TextEditingController nameServer;

  File? avatar;

  @override
  void onInit() {
    super.onInit();
    nameServer = TextEditingController();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    nameServer.dispose();
    super.dispose();
  }

  void selectedTypeServer(String type) {
    typeServer = type;
    update(['selected_type_server']);
  }

  void nextPage() {
    if (nameServer.text.isEmpty || typeServer.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Please filled all field.',
        duration: Duration(seconds: 2),
      ));
      return;
    }
    pageController.nextPage(duration: 500.milliseconds, curve: Curves.easeIn);
  }

  void get previousPage {
    pageController.previousPage(
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  void pickAvatar() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      avatar = File(image.path);
      update();
    }
  }

  void get continueWithAvatar async {
    try {
      await _channelRepository.createChannel(
          name: nameServer.text, type: typeServer, image: avatar);
    } catch (e) {
      Get.log(e.toString());
      throw 'e';
    }
  }

  void get continueWithoutAvatar async {
    try {
      await _channelRepository.createChannel(
        name: nameServer.text,
        type: typeServer,
      );
    } catch (e) {
      throw 'e';
    }
  }
}
