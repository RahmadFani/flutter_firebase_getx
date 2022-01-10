import 'package:flutter/material.dart';
import 'package:flutter_getx_starterpack/modules/home_module/controller.dart';
import 'package:get/get.dart';

class SelectedChannelHome extends GetView<HomeController> {
  const SelectedChannelHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (state) {
          return Container();
        });
  }
}
