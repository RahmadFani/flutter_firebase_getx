part of '../page.dart';

class ImageForm extends GetView<ChannelCreateController> {
  const ImageForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Stack(
          children: [
            Container(
                constraints: const BoxConstraints.expand(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Choose your server image',
                      textAlign: TextAlign.center,
                      style: headingOneText(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: controller.pickAvatar,
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Stack(
                          children: [
                            controller.avatar == null
                                ? Lottie.asset(
                                    'assets/lottiefiles/world_green.json',
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover)
                                : Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius:
                                            BorderRadius.circular(80)),
                                    width: 150,
                                    height: 150,
                                    child: Image.file(controller.avatar!)),
                            const Positioned(
                                bottom: 0,
                                right: 15,
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 35,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        decoration: controller.avatar == null
                            ? null
                            : BoxDecoration(
                                boxShadow: [
                                    BoxShadow(
                                        color: Colors.green.withOpacity(.5),
                                        spreadRadius: 0,
                                        blurRadius: 10)
                                  ],
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(80)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                )),
            Positioned(
              top: 50,
              left: 30,
              child: InkWell(
                onTap: () => controller.previousPage,
                child: const Icon(
                  Icons.arrow_back,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
                bottom: 30,
                left: 30,
                right: 30,
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(35)))),
                          onPressed: controller.avatar == null
                              ? null
                              : () => controller.continueWithAvatar,
                          child: Text(
                            'CREATE SERVER',
                            style: TextStyle(
                                color: Get.theme.primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => controller.continueWithoutAvatar,
                      child: SizedBox(
                        child: Text('I want change avatar later !',
                            textAlign: TextAlign.center,
                            style: headingFiveText(
                                color: Colors.white.withOpacity(.9))),
                      ),
                    ),
                  ],
                ))
          ],
        );
      },
    );
  }
}
