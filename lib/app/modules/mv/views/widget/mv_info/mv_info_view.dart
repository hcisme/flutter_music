import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic/app/modules/mv/controllers/mv_controller.dart';
import 'package:cloudmusic/app/modules/mv/views/widget/comment/mvComment.dart';
import 'package:cloudmusic/app/services/format_timestamp/time_tool.dart';
import 'package:cloudmusic/app/services/iconfont/iconfont.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MvInfoView extends GetView<MvController> {
  const MvInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenAdapter.height(600),
        padding: EdgeInsets.only(
            left: ScreenAdapter.height(24), top: ScreenAdapter.height(24)),
        child: Obx(() {
          var d = controller.detailInfo;
          var singer = controller.singer;
          return d.isEmpty || singer.isEmpty
              ? const Text('')
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  CachedNetworkImageProvider('${d['cover']}'),
                            ),
                            Container(
                              height: ScreenAdapter.height(120),
                              width: ScreenAdapter.width(680),
                              padding: EdgeInsets.only(
                                  left: ScreenAdapter.width(16)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${d['name']}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        '${d['artistName']} ${Tool.formatPlayCount(singer['fansCnt'])} 粉丝',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.fs(36),
                                            color: Colors.black38)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Chip(
                          label: d['artists'][0]['followed']
                              ? const Text('已关注')
                              : const Text(
                                  '+ 关注',
                                  style: TextStyle(color: Colors.red),
                                ),
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.red),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          '${d['desc'] == null || d['desc'] == '' ? '暂无简介' : d['desc']}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenAdapter.fs(48)),
                        )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_drop_down_outlined))
                      ],
                    ),
                    Text(
                        '${Tool.formatPlayCount(d['playCount'])}次观看 ${d['publishTime']}',
                        style: TextStyle(
                            fontSize: ScreenAdapter.fs(38),
                            color: Colors.black38)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Icon(
                                  Icons.add_to_photos_sharp,
                                  color: Colors.black54,
                                  size: ScreenAdapter.fs(56),
                                ),
                                const Text(
                                  '收藏',
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Icon(
                                  IconFont.share,
                                  color: Colors.black54,
                                  size: ScreenAdapter.fs(56),
                                ),
                                const Text(
                                  '13888',
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              controller.newComments.value = [];
                              controller.hotComments.value = [];
                              controller.page = 0;
                              controller.isHaveData = true;
                              await controller.getAllComments();
                              await Get.bottomSheet(const MvComment());
                            },
                            child: Column(
                              children: [
                                Icon(
                                  IconFont.comment,
                                  color: Colors.black54,
                                  size: ScreenAdapter.fs(56),
                                ),
                                const Text(
                                  '评论',
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Icon(
                                  IconFont.star,
                                  color: Colors.black54,
                                  size: ScreenAdapter.fs(56),
                                ),
                                const Text(
                                  '1000',
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            ),
                          )
                        ]),
                  ],
                );
        }));
  }
}
