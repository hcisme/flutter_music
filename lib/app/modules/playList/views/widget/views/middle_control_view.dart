import 'package:cloudmusic/app/modules/playList/controllers/play_list_controller.dart';
import 'package:cloudmusic/app/services/format_timestamp/time_tool.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MiddleControlView extends GetView<PlayListController> {
  const MiddleControlView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var info = controller.commentInfo;
      return Container(
          height: ScreenAdapter.height(110),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    offset: const Offset(0.0, 2.0), //阴影y轴偏移量
                    blurRadius: 1, //阴影模糊程度
                    spreadRadius: 0 //阴影扩散程度
                    )
              ],
              borderRadius: BorderRadius.circular(ScreenAdapter.height(100))),
          child: info.isEmpty
              ? const Text('')
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...List.generate(controller.middleIcons.length, (index) {
                      var item = controller.middleIcons[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              item['icon'],
                              color: Colors.black54,
                              size: ScreenAdapter.fs(50),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            index == 1
                                ? Tool.formatPlayCount(info['total'])
                                : item['title'],
                            style: TextStyle(fontSize: ScreenAdapter.fs(36)),
                          ),
                          index + 1 == controller.middleIcons.length
                              ? const Text('')
                              : const SizedBox(
                                  width: 20,
                                ),
                          index + 1 == controller.middleIcons.length
                              ? const Text('')
                              : Container(
                                  width: ScreenAdapter.width(1),
                                  height: double.infinity,
                                  color: Colors.black26,
                                  margin: EdgeInsets.symmetric(
                                      vertical: ScreenAdapter.height(24)),
                                ),
                        ],
                      );
                    })
                  ],
                ));
    });
  }
}
