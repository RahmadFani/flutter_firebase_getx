import 'package:flutter/cupertino.dart';
import 'package:flutter_getx_starterpack/data/repositories/channel_repository.dart';
import 'package:get/get.dart';

class ChannelCreateController extends GetxController {
  final ChannelRepository _channelRepository;
  ChannelCreateController({ChannelRepository? channelRepository})
      : _channelRepository = channelRepository ?? ChannelRepository();

  late PageController pageController;

  String typeServer = '';
  late TextEditingController nameServer;

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
}
