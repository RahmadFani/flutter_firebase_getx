import 'package:flutter/material.dart';
import 'package:flutter_getx_starterpack/data/models/channel/channel.dart'
    as channel_model;
import 'package:flutter_getx_starterpack/data/models/profile/profile.dart'
    as profile_model;
import 'package:flutter_getx_starterpack/global_widgets/custom_image/generate_image_from_storage.dart';
import 'package:flutter_getx_starterpack/modules/app_module/controller.dart';
import 'package:flutter_getx_starterpack/modules/home_module/controller.dart';
import 'package:flutter_getx_starterpack/modules/home_module/selected_channel.dart';
import 'package:flutter_getx_starterpack/modules/home_module/widgets/splash_home.dart';
import 'package:flutter_getx_starterpack/routes/app_pages.dart';
import 'package:flutter_getx_starterpack/values/text_style.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

part 'widgets/empty_channels_profile.dart';
part 'widgets/home_drawer.dart';
part 'widgets/home_drawer_end.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (_) {
          if (controller.profile.value is profile_model.Data) {
            profile_model.Data profile =
                controller.profile.value as profile_model.Data;
            return Stack(
              children: [
                _homeBody,
                if (profile.channels!.isEmpty) const EmptyChnnelsProfile()
              ],
            );
          }
          return const SplashHomeWidget();
        });
  }

  Widget get _homeBody {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: (controller.channel.value is channel_model.Empty)
              ? const Text('Home')
              : Text((controller.channel.value as channel_model.Data).name!)),
      drawer: const HomeDrawer(),
      endDrawer: (controller.channel.value is channel_model.Empty)
          ? null
          : const HomeDrawerEnd(),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: (controller.channel.value is channel_model.Empty)
              ? const Center(
                  child: Text('Unselected channel'),
                )
              : const SelectedChannelHome(),
        ),
      ),
    );
  }
}
