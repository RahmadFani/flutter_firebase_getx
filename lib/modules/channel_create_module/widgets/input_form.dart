part of '../page.dart';

class InputForm extends GetView<ChannelCreateController> {
  const InputForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        id: 'selected_type_server',
        builder: (context) {
          return KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisibile) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              constraints: const BoxConstraints.expand(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create Server',
                    textAlign: TextAlign.center,
                    style: headingOneText(),
                  ),
                  sizedh20,
                  sizedh20,
                  CoolTextFormCustom(
                    controller: controller.nameServer,
                    textAlign: TextAlign.center,
                    label: 'Your Name Server..',
                  ),
                  sizedh15,
                  CupertionPickerCustom<String>(
                    onSelected: controller.selectedTypeServer,
                    builder: (_, b) {
                      return Center(child: Text(b));
                    },
                    list: const [
                      'Public',
                      'Private',
                    ],
                    alignment: Alignment.center,
                    textAlign: TextAlign.center,
                    label: controller.typeServer.isEmpty
                        ? 'Select Type Server..'
                        : controller.typeServer,
                  ),
                  if (!isKeyboardVisibile)
                    Column(
                      children: [
                        sizedh20,
                        sizedh10,
                        SizedBox(
                          height: 65,
                          width: context.width,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                              onPressed: controller.nextPage,
                              child: Text(
                                'CONTINUE',
                                style: TextStyle(
                                    color: Get.theme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )),
                        ),
                      ],
                    )
                ],
              ),
            );
          });
        });
  }
}
