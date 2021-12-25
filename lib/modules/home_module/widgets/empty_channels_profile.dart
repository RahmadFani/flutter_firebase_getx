part of '../page.dart';

class EmptyChnnelsProfile extends GetView<HomeController> {
  const EmptyChnnelsProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    profile_model.Data profile = controller.profile.value as profile_model.Data;
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Hi, ${profile.nickname!}',
              textAlign: TextAlign.center,
              style: headingOneText(color: Get.theme.primaryColor),
            ),
            Text(
              'Choose your server',
              textAlign: TextAlign.center,
              style: headingOneText(color: Get.theme.primaryColor),
            ),
            const SizedBox(
              height: 20,
            ),
            Lottie.asset('assets/lottiefiles/world_green.json',
                width: 180, height: 180),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              height: 65,
              width: context.width,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Get.theme.primaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)))),
                  onPressed: () {},
                  child: const Text(
                    'JOIN SERVER',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 65,
              width: context.width,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)))),
                  onPressed: () => Get.toNamed(Routes.CHANNEL_CREATE),
                  child: Text(
                    'CREATE SERVER',
                    style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
