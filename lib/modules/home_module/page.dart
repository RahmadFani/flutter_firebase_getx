import 'package:flutter/material.dart';
import 'package:flutter_getx_starterpack/data/models/user/user.dart';
import 'package:flutter_getx_starterpack/modules/app_module/controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Obx(() {
            return Text((appController.currentUser.value as Data).email ?? '');
          }),
          ElevatedButton(
            onPressed: () {
              appController.userLoggedOut;
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
