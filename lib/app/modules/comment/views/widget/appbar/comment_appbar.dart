import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic/app/modules/comment/controllers/comment_controller.dart';
import 'package:cloudmusic/app/services/iconfont/iconfont.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:cloudmusic/app/services/size/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentAppBar extends GetView<CommentController> {
  const CommentAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        '评论(${Get.arguments['commentCount']})',
        style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w400,
            fontSize: ScreenAdapter.fs(50)),
      ),
      leadingWidth: ScreenAdapter.width(120),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.black54,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              IconFont.share,
              color: Colors.black54,
            ))
      ],
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(Unified.appBarHeight),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: ScreenAdapter.width(32)),
                    padding: EdgeInsets.all(ScreenAdapter.width(20)),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.circular(ScreenAdapter.width(100))),
                    child: CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(Get.arguments['picUrl']),
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(16),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                        '${Get.arguments['name']} ${Get.arguments['alia']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(
                        '${Get.arguments['singer']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: ScreenAdapter.fs(32)),
                      )),
                ],
              ),
              SizedBox(
                height: ScreenAdapter.height(8),
              )
            ],
          )),
    );
  }
}
