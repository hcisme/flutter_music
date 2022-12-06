import 'package:cloudmusic/app/modules/discovery/controllers/discovery_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoveryAppBar extends GetView<DiscoveryController> {
  const DiscoveryAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppBar(
          backgroundColor: const Color.fromARGB(230, 252, 243, 236)
              .withOpacity(controller.opacity.value),
          elevation: 0,
          leading: Builder(builder: (context) {
            return Container(
                margin: EdgeInsets.only(left: ScreenAdapter.width(40)),
                child: IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  iconSize: ScreenAdapter.fs(88),
                  color: Colors.black54,
                  icon: const Icon(Icons.menu),
                ));
          }),
          title: InkWell(
            onTap: () {
              Get.toNamed('/search', arguments: {
                'keyWord': controller.searchSuggest['showKeyword']
              });
            },
            child: Container(
              width: double.infinity,
              height: ScreenAdapter.height(100),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(ScreenAdapter.width(34), 0, 4, 0),
                    child: const Icon(Icons.search, color: Colors.black26),
                  ),
                  Text(
                    '${controller.searchSuggest.isEmpty ? '' : controller.searchSuggest['showKeyword']}',
                    style: TextStyle(
                        fontSize: ScreenAdapter.fs(38), color: Colors.black45),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
