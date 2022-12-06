import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic/app/modules/discovery/controllers/discovery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoveryDrawer extends GetView<DiscoveryController> {
  const DiscoveryDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color.fromRGBO(232, 232, 232, 1),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: UserAccountsDrawerHeader(
                            currentAccountPicture: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://p2.music.126.net/WI_D4jN9VnTGxqH4qmmfzw==/109951167897209873.jpg',
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            accountName: const Text("池海成"),
                            accountEmail: const Text("chc1231231@163.com")))
                  ],
                ),
              ],
            ),
            Card(
              elevation: 0,
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.palette),
                    title: Text('主题'),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
