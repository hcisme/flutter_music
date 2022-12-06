import 'package:cloudmusic/app/modules/discovery/controllers/discovery_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CateGoryView extends GetView<DiscoveryController> {
  const CateGoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenAdapter.getScreenWidth(),
        height: ScreenAdapter.height(250),
        padding: EdgeInsets.only(top: ScreenAdapter.width(32)),
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          children: [
            Wrap(
                spacing: ScreenAdapter.width(48),
                children: controller.cateGoryList.map((item) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: ScreenAdapter.width(item['id'] == 1 ? 40 : 0),
                        right: ScreenAdapter.width(item['id'] == 10 ? 40 : 0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: ScreenAdapter.width(138),
                          height: ScreenAdapter.height(138),
                          margin: EdgeInsets.only(
                            bottom: ScreenAdapter.height(4),
                          ),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 235, 118, 109)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                  ScreenAdapter.width(74))),
                          child: IconButton(
                            icon: Icon(
                              item["icon"],
                              color: const Color.fromRGBO(221, 0, 27, 1),
                              size: ScreenAdapter.fs(70),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Text(
                          item["title"],
                          style: TextStyle(
                              fontSize: ScreenAdapter.fs(34),
                              color: Colors.black54),
                        )
                      ],
                    ),
                  );
                }).toList())
          ],
        ));
  }
}
