import 'package:cloudmusic/app/common/Singles/custome_single_music.dart';
import 'package:cloudmusic/app/modules/playList/controllers/play_list_controller.dart';
import 'package:cloudmusic/app/modules/tabs/controllers/tabs_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';

class SongListView extends GetView<PlayListController> {
  const SongListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenAdapter.width(24)),
        child: Obx(() {
          return controller.songList.isNotEmpty
              ? AnimationLimiter(
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: AnimationConfiguration.toStaggeredList(
                      childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                      children: controller.songList.map((item) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenAdapter.height(8)),
                          child: CustomeSingleMusic(
                            title: item['name'],
                            subTitle: item['alia'].join('/'),
                            artist: item['ar']
                                .map((record) => record['name'])
                                .join('/'),
                            level: true,
                            isVip: item['fee'] == 1,
                            originCoverType: true,
                            onTap: () {
                              Get.find<TabsController>().getUrl(item['id']);
                            },
                            isMv: item['mv'] != 0,
                            onTapToPlayMmv: () {
                              Get.toNamed('/mv',
                                  arguments: {'mvId': item['mv']});
                            },
                            onTapMore: () {},
                          ),
                        );
                      }).toList()),
                ))
              : const Text('');
        }));
  }
}
