import 'package:chewie/chewie.dart';
import 'package:cloudmusic/app/modules/mv/controllers/mv_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MvPlayerView extends GetView<MvController> {
  const MvPlayerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenAdapter.height(600),
        child: Obx(() {
          return controller.videoUrl.value != ''
              ? Chewie(
                  controller: controller.chewieController,
                )
              : Container();
        }));
  }
}
