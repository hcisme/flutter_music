import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic/app/modules/playList/controllers/play_list_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaylistAppBarView extends GetView<PlayListController> {
  const PlaylistAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var info = controller.detailInfo;
      return info.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        '${info['coverImgUrl']}',
                        scale: 2,
                      ))),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30), //背景模糊化
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: Text(
                      '歌单',
                      style: TextStyle(fontSize: ScreenAdapter.fs(48)),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search_rounded)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert_rounded))
                    ],
                  ),
                ),
              ))
          : const Text('');
    });
  }
}
