import 'package:cloudmusic/app/common/Singles/custome_single_music.dart';
import 'package:cloudmusic/app/modules/result/controllers/result_controller.dart';
import 'package:cloudmusic/app/modules/tabs/controllers/tabs_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';

class ResultMusicView extends GetView<ResultController> {
  const ResultMusicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenAdapter.width(20)),
        child: Obx(() {
          return controller.resultList.isEmpty
              ? Container(
                  margin: const EdgeInsets.only(top: 200),
                  alignment: Alignment.center,
                  child: Text(controller.status.value))
              : Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenAdapter.width(32))),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: ScreenAdapter.height(100),
                      margin: EdgeInsets.only(left: ScreenAdapter.width(50)),
                      child: Text(
                        "相关音乐",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenAdapter.fs(38)),
                      ),
                    ),
                    const Divider(),
                    // 音乐列表
                    AnimationLimiter(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: AnimationConfiguration.toStaggeredList(
                              childAnimationBuilder: (widget) => SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: widget,
                                    ),
                                  ),
                              children: controller.resultList.map(
                                (item) {
                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ScreenAdapter.width(16)),
                                        child: CustomeSingleMusic(
                                          title: '${item['name']}',
                                          titleColor: Colors.blueAccent,
                                          level: item['privilege']['maxbr'] ==
                                              999000,
                                          artist:
                                              '${item['ar'].map((v) => v['name']).join('/')}',
                                          isVip: item['fee'] == 1,
                                          subTitle: '${item['al']['name']}',
                                          originCoverType:
                                              item['originCoverType'] == 1,
                                          onTap: () {
                                            Get.find<TabsController>()
                                                .getUrl(item['id']);
                                          },
                                          isMv: item['mv'] != 0,
                                          onTapToPlayMmv: () {
                                            Get.toNamed('/mv', arguments: {
                                              'mvId': item['mv']
                                            });
                                          },
                                        ),
                                      ),
                                      const Divider()
                                    ],
                                  );
                                },
                              ).toList())),
                    )
                  ]),
                );
        }));
  }
}
