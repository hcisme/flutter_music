import 'package:cloudmusic/app/common/Card/custome_card.dart';
import 'package:cloudmusic/app/modules/playLists/controllers/play_lists_controller.dart';
import 'package:cloudmusic/app/services/format_timestamp/time_tool.dart';
import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayListsItemView extends GetView<PlayListsController> {
  final ScrollPhysics physics;

  const PlayListsItemView({super.key, required this.physics});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        physics: physics,
        controller: controller.scrollController,
        padding: EdgeInsets.all(ScreenAdapter.height(24)),
        children: [
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: ScreenAdapter.width(48),
            runSpacing: ScreenAdapter.width(48),
            children: controller.playList.map((item) {
              return CustomeCard(
                  onTap: () {
                    Get.toNamed('/play-list',
                        arguments: {'playlistId': item['id']});
                  },
                  coverImg: HttpsClient.getClipImg(item['coverImgUrl']),
                  playCount: Tool.formatPlayCount(item['playCount']),
                  title: item['name']);
            }).toList(),
          )
        ],
      );
    });
  }
}
