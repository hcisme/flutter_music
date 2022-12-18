import 'package:cloudmusic/app/common/AnimationList/animationList.dart';
import 'package:cloudmusic/app/common/CommentItem/common_item.dart';
import 'package:cloudmusic/app/modules/mv/controllers/mv_controller.dart';
import 'package:cloudmusic/app/modules/mv/views/widget/checkout/checkout.dart';
import 'package:cloudmusic/app/services/format_timestamp/time_tool.dart';
import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MvComment extends GetView<MvController> {
  const MvComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.getScreenHeight(),
      padding: EdgeInsets.all(ScreenAdapter.width(32)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ScreenAdapter.height(50)),
              topRight: Radius.circular(ScreenAdapter.height(50)))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(ScreenAdapter.height(32)),
                child: Text(
                  '评论：${controller.commentTotal}',
                  style: TextStyle(fontSize: ScreenAdapter.fs(48)),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.close_rounded),
              )
            ],
          ),
          const MvCommentCheckout(),
          Obx(() {
            return SizedBox(
              height:
                  ScreenAdapter.getScreenHeight() - ScreenAdapter.width(1370),
              child: AnimationListView(
                  key: ValueKey(controller.mostNew.value),
                  controller: controller.refreshController,
                  fn: () {
                    return controller.getAllComments();
                  },
                  verticalOffset: 50,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(ScreenAdapter.height(32)),
                  children: (controller.mostNew.value == 0
                          ? controller.newComments
                          : controller.hotComments)
                      .map((item) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonItem(
                          avatar:
                              HttpsClient.getClipImg(item['user']['avatarUrl']),
                          isVip: item['user']['vipType'] != 0,
                          likedCount: Tool.formatPlayCount(item['likedCount']),
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
          })
        ],
      ),
    );
  }
}
