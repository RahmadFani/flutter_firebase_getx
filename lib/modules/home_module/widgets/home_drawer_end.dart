part of '../page.dart';

class HomeDrawerEnd extends GetView<HomeController> {
  const HomeDrawerEnd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        id: 'channel',
        builder: (HomeController ctrl) {
          List<channel_model.Channel> channels = ctrl.channels;
          profile_model.Data profile = ctrl.profile.value as profile_model.Data;
          return Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: SafeArea(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  if (channels is channel_model.Empty)
                    const SizedBox.shrink()
                  else
                    const ListTile(
                      title: Text('Member'),
                    ),
                  ListTile(
                    leading: GenerateImageFromFirebaseStorage(
                      image: profile.avatar,
                      imageSize: 50,
                    ),
                    title: Text(profile.nickname!),
                  ),
                  ...List.generate(channels.length, (index) {
                    channel_model.Data channel =
                        channels[index] as channel_model.Data;
                    return ListTile(
                      leading: GenerateImageFromFirebaseStorage(
                        image: channel.image,
                        imageSize: 50,
                        withIcon: const Icon(
                          Icons.image,
                          size: 40,
                        ),
                      ),
                      title: Text(channel.name!),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        });
  }
}
