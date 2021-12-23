import 'package:flutter/material.dart';
import 'package:flutter_getx_starterpack/global_widgets/select/cupertino_picker_custom.dart';
import 'package:flutter_getx_starterpack/global_widgets/text_form/cool_text_form.dart';
import 'package:flutter_getx_starterpack/modules/channel_create_module/controller.dart';
import 'package:flutter_getx_starterpack/values/sizedbox.dart';
import 'package:flutter_getx_starterpack/values/text_style.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

part 'widgets/input_form.dart';
part 'widgets/image_form.dart';

class ChannelCreatePage extends GetView<ChannelCreateController> {
  const ChannelCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [InputForm(), ImageForm()],
      ),
    );
  }
}
