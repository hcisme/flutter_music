import 'package:cloudmusic/app/modules/playLists/views/widget/category/category.dart';
import 'package:cloudmusic/app/modules/playLists/views/widget/list/playlists.dart';
import 'package:cloudmusic/app/modules/playLists/views/widget/tabs/playlist_tabs.dart';
import 'package:cloudmusic/app/services/enum/data.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/play_lists_controller.dart';

class PlayListsView extends GetView<PlayListsController> {
  const PlayListsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '精品歌单',
            style:
                TextStyle(color: Colors.black45, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(ScreenAdapter.height(140)),
              child: Stack(
                children: const [PlaylistTabs(), PlaylistCategory()],
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed('/search', arguments: {'keyWord': ''});
                },
                icon: const Icon(Icons.search_rounded))
          ],
        ),
        body: EasyRefresh.builder(
          controller: controller.easyRefreshController,
          onRefresh: () async {
            controller.resetPagination();
            DataStatus status = await controller.request();
            switch (status) {
              case DataStatus.SUCCESS:
                return IndicatorResult.success;
              case DataStatus.FAIL:
                return IndicatorResult.fail;
              default:
            }
          },
          onLoad: () async {
            DataStatus status = await controller.request();
            switch (status) {
              case DataStatus.SUCCESS:
                return IndicatorResult.success;
              case DataStatus.FAIL:
                return IndicatorResult.fail;
              case DataStatus.NODATA:
                return IndicatorResult.noMore;
              default:
            }
          },
          childBuilder: ((context, physics) {
            return PlayListsItemView(
              physics: physics,
            );
          }),
        ));
  }
}
