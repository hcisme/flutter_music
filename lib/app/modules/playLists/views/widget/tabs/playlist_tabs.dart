import 'package:cloudmusic/app/modules/playLists/controllers/play_lists_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaylistTabs extends GetView<PlayListsController> {
  const PlaylistTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: (value) {
        controller.cat.value = controller.tabs[value];
      },
      isScrollable: true,
      controller: controller.tabController,
      // 指示器
      indicatorColor: Colors.red,
      // 选中文字
      labelColor: Colors.red,
      // 选项卡宽度
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelColor: Colors.black,
      tabs: controller.tabs
          .map((item) => Tab(
                child: Text(item),
              ))
          .toList(),
    );
  }
}
