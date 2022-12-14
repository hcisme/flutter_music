import 'package:cloudmusic/app/modules/playList/views/widget/appbar/appbar.dart';
import 'package:cloudmusic/app/modules/playList/views/widget/song_list/song_list_view.dart';
import 'package:cloudmusic/app/modules/playList/views/widget/top_cover/top_cover_view.dart';
import 'package:cloudmusic/app/modules/playList/views/widget/views/middle_bottom_view.dart';
import 'package:cloudmusic/app/modules/playList/views/widget/views/middle_control_view.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:cloudmusic/app/services/size/size.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/play_list_controller.dart';

class PlayListView extends GetView<PlayListController> {
  const PlayListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Unified.appBarHeight),
          child: const PlaylistAppBarView(),
        ),
        body: EasyRefresh.builder(
          controller: controller.refreshController,
          onLoad: () async {
            controller.getPageMusicList().then((success) {
              try {
                if (success == 1) {
                  controller.refreshController.finishLoad();
                } else if (success == 0) {
                  controller.refreshController.finishLoad(IndicatorResult.fail);
                }
              } catch (e) {}
            });
          },
          childBuilder: (BuildContext context, ScrollPhysics physics) {
            return ListView(
              physics: physics,
              children: [
                Stack(
                  children: [
                    // 防止堆叠
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TopCoverView(),
                        SizedBox(
                          height: ScreenAdapter.height(100),
                        ),
                        const MiddleBottomView(),
                        const SongListView(),
                      ],
                    ),
                    Positioned(
                        top: ScreenAdapter.width(545),
                        left: ScreenAdapter.width(140),
                        right: ScreenAdapter.width(140),
                        child: const MiddleControlView()),
                  ],
                ),
              ],
            );
          },
        ));
  }
}
