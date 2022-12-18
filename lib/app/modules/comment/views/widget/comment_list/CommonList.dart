import 'package:cloudmusic/app/common/CommentItem/common_item.dart';
import 'package:cloudmusic/app/modules/comment/controllers/comment_controller.dart';
import 'package:cloudmusic/app/services/enum/data.dart';
import 'package:cloudmusic/app/services/format_timestamp/time_tool.dart';
import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class CommentList extends GetView<CommentController> {
  const CommentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenAdapter.getScreenHeight() - ScreenAdapter.height(596),
        color: Colors.white,
        child: Obx(() {
          return controller.newComments.isEmpty
              ? const Text('')
              : AnimationLimiter(
                  key: ValueKey(controller.mostNew.value),
                  child: EasyRefresh.builder(
                      controller: controller.refreshController,
                      onLoad: () async {
                        DataStatus status = await controller.getAllComments();
                        switch (status) {
                          case DataStatus.SUCCESS:
                            controller.refreshController
                                .finishLoad(IndicatorResult.success);
                            break;
                          case DataStatus.FAIL:
                            controller.refreshController
                                .finishLoad(IndicatorResult.fail);
                            break;
                          case DataStatus.NODATA:
                            controller.refreshController
                                .finishLoad(IndicatorResult.noMore);
                            break;
                        }
                      },
                      childBuilder: (context, physics) {
                        return ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(ScreenAdapter.width(32)),
                          physics: physics,
                          children: AnimationConfiguration.toStaggeredList(
                              childAnimationBuilder: (widget) => SlideAnimation(
                                    verticalOffset: 80.0,
                                    child: FadeInAnimation(
                                      child: widget,
                                    ),
                                  ),
                              children: controller.renderComments.map((item) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CommonItem(
                                      avatar: HttpsClient.getClipImg(
                                          item['user']['avatarUrl']),
                                      isVip: item['user']['vipType'] != 0,
                                      likedCount: Tool.formatPlayCount(
                                          item['likedCount']),
                                      name: item['user']['nickname'],
                                      publishTime: item['timeStr'],
                                      content: item['content'],
                                      liked: item['liked'],
                                    ),
                                    const Divider()
                                  ],
                                );
                              }).toList()),
                        );
                      }));
        }));
  }
}
