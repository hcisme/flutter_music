import 'package:cloudmusic/app/modules/playLists/controllers/play_lists_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaylistCategory extends GetView<PlayListsController> {
  const PlaylistCategory({super.key});

  @override
  Widget build(BuildContext context) {
    controller.tabs.removeLast();
    return Positioned(
        right: 0,
        top: 0,
        width: ScreenAdapter.width(160),
        height: ScreenAdapter.height(140),
        child: InkWell(
          onTap: () {
            Get.bottomSheet(
              Container(
                height: 400,
                padding: EdgeInsets.all(ScreenAdapter.height(32)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(ScreenAdapter.height(50)),
                        topRight: Radius.circular(ScreenAdapter.height(50)))),
                child: Obx(() {
                  return Wrap(
                    spacing: ScreenAdapter.width(32),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(ScreenAdapter.height(32)),
                            child: Text(
                              '歌单分类',
                              style: TextStyle(fontSize: ScreenAdapter.fs(48)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.close_rounded),
                          )
                        ],
                      ),
                      ...controller.tabs
                          .map((item) => InkWell(
                                onTap: () async {
                                  controller.cat.value = item;
                                  controller.tabController.animateTo(
                                      controller.tabs.indexWhere(
                                          (element) => element == item));
                                  Get.back();
                                },
                                child: Chip(
                                  backgroundColor: item == controller.cat.value
                                      ? Colors.red
                                      : const Color.fromARGB(
                                          255, 218, 214, 214),
                                  label: Text(
                                    item,
                                    style: TextStyle(
                                      color: item == controller.cat.value
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              ))
                          .toList()
                    ],
                  );
                }),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.white, //底色,阴影颜色
                offset: Offset(-0.5, 0), //阴影位置,从什么位置开始
                blurRadius: 1, // 阴影模糊层度
                spreadRadius: 0, //阴影模糊大小
              )
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.menu,
                  size: ScreenAdapter.fs(56),
                  color: Colors.red,
                ),
                Text(
                  '更多',
                  style: TextStyle(
                      fontSize: ScreenAdapter.fs(36), color: Colors.red),
                )
              ],
            ),
          ),
        ));
  }
}
