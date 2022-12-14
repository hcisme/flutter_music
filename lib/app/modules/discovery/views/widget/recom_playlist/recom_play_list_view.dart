import 'package:cloudmusic/app/common/Card/custome_card.dart';
import 'package:cloudmusic/app/modules/discovery/controllers/discovery_controller.dart';
import 'package:cloudmusic/app/services/format_timestamp/time_tool.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecomPlayListView extends GetView<DiscoveryController> {
  const RecomPlayListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(
              left: ScreenAdapter.width(32), right: ScreenAdapter.width(32)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "推荐歌单",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenAdapter.fs(48)),
              ),
              Container(
                height: ScreenAdapter.height(80),
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: ScreenAdapter.width(40),
                    right: ScreenAdapter.width(40)),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12.withOpacity(0.1)),
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.width(40))),
                child: Text(
                  "更多 >",
                  style: TextStyle(
                      color: Colors.black87, fontSize: ScreenAdapter.fs(38)),
                ),
              ),
            ],
          ),
        ),
        // 内容
        Container(
            width: ScreenAdapter.getScreenWidth(),
            height: ScreenAdapter.height(390),
            margin: EdgeInsets.only(top: ScreenAdapter.height(36)),
            child: Obx((() {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.playlists.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = controller.playlists[index];
                  return CustomeCard(
                    onTap: () {
                      Get.toNamed('/play-list',
                          arguments: {'playlistId': item['id']});
                    },
                    coverImg: item['picUrl'],
                    playCount: Tool.formatPlayCount(item['playCount']),
                    title: item["name"],
                    margin: EdgeInsets.only(
                        left: ScreenAdapter.width(index == 0 ? 32 : 16),
                        right: ScreenAdapter.width(index == 0 ? 32 : 16)),
                  );
                },
              );
            })))
      ],
    );
  }
}
