part of '../page.dart';

class HomeDrawer extends GetView<HomeController> {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<channel_model.Channel> channels = controller.channels;
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          if (channels is channel_model.Empty)
            const SizedBox.shrink()
          else
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer ss'),
            ),
          ...List.generate(channels.length, (index) {
            channel_model.Data channel = channels[index] as channel_model.Data;
            return ListTile(
              title: Text(channel.name!),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            );
          }),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Get.find<AppController>().userLoggedOut;
            },
          )
        ],
      ),
    );
  }
}
