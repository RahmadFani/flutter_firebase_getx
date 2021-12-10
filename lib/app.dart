import 'package:flutter/material.dart';
import 'package:flutter_getx_starterpack/modules/app_module/binding.dart';
import 'package:flutter_getx_starterpack/routes/app_pages.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: Routes.INITIAL,
      getPages: AppPages.pages,
      initialBinding: AppBinding(),
    );
  }
}
