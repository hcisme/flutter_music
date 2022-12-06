import 'package:cloudmusic/app/common/MvCard/mv_card.dart';
import 'package:cloudmusic/app/modules/mv/controllers/mv_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';

class RelatedRecomView extends GetView<MvController> {
  const RelatedRecomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(ScreenAdapter.width(24)),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                  left: ScreenAdapter.width(24),
                  bottom: ScreenAdapter.width(24),
                  right: ScreenAdapter.width(24)),
              child: const Text(
                '相关mv',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Obx(() {
              return controller.simiMvs.isEmpty
                  ? const Text('')
                  : AnimationLimiter(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: AnimationConfiguration.toStaggeredList(
                              childAnimationBuilder: (widget) => SlideAnimation(
                                    verticalOffset: 80.0,
                                    child: FadeInAnimation(
                                      child: widget,
                                    ),
                                  ),
                              children: controller.simiMvs.map((item) {
                                return CustomeMvCard(
                                    onTap: () async {
                                      controller.videoUrl.value = '';
                                      controller.id = item['id'];
                                      await controller.request().then((value) {
                                        controller.initVideoPlayer();
                                      });
                                    },
                                    picurl: item['cover'],
                                    isMv: item['id'] != 0,
                                    title: item['name'],
                                    duration: item['duration'],
                                    artist: item['artists']
                                        .map((v) => v['name'])
                                        .join('/'),
                                    playCount: item['playCount']);
                              }).toList())));
            })
          ],
        ));
  }
}
