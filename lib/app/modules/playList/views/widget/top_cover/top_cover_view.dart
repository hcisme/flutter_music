import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic/app/common/Tip/tip.dart';
import 'package:cloudmusic/app/modules/playList/controllers/play_list_controller.dart';
import 'package:cloudmusic/app/services/format_timestamp/time_tool.dart';
import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopCoverView extends GetView<PlayListController> {
  const TopCoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var info = controller.detailInfo;
      return info.isNotEmpty
          ? Container(
              width: ScreenAdapter.getScreenWidth(),
              height: ScreenAdapter.height(600),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      scale: 3,
                      repeat: ImageRepeat.repeatY,
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          '${info['coverImgUrl']}'))),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 30,
                      sigmaY: 30,
                      tileMode: TileMode.repeated), //背景模糊化
                  child: Container(
                      padding: EdgeInsets.all(ScreenAdapter.width(16)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: ScreenAdapter.width(32)),
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 0,
                                    left: ScreenAdapter.width(20),
                                    child: Container(
                                      // margin: EdgeInsets.all(ScreenAdapter.width(16)),
                                      width: ScreenAdapter.height(300),
                                      height: ScreenAdapter.height(100),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                              ScreenAdapter.width(24))),
                                    )),
                                Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenAdapter.width(16)),
                                      width: ScreenAdapter.height(340),
                                      height: ScreenAdapter.height(340),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              ScreenAdapter.width(24))),
                                      child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: HttpsClient.getClipImg(
                                              info['coverImgUrl'])),
                                    ),
                                    Positioned(
                                        top: ScreenAdapter.height(24),
                                        right: ScreenAdapter.width(6),
                                        child: SmallTip(
                                            playCount: Tool.formatPlayCount(
                                                info['playCount'])))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Container(
                                  width: ScreenAdapter.getScreenWidth() -
                                      ScreenAdapter.width(480),
                                  height: ScreenAdapter.height(380),
                                  margin:
                                      EdgeInsets.all(ScreenAdapter.width(32)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${info['name']}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize:
                                                      ScreenAdapter.fs(38)),
                                            ),
                                          ),
                                          Icon(
                                            Icons
                                                .arrow_drop_down_circle_outlined,
                                            color: Colors.white,
                                            size: ScreenAdapter.fs(48),
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: ScreenAdapter.width(80),
                                                height:
                                                    ScreenAdapter.height(80),
                                                margin: EdgeInsets.only(
                                                    right: ScreenAdapter.width(
                                                        16)),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                          HttpsClient
                                                              .getClipImg(info[
                                                                      'creator']
                                                                  [
                                                                  'avatarUrl'])),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${info['creator']['nickname']} >",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize:
                                                          ScreenAdapter.fs(38),
                                                      color: Colors.white60),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: ScreenAdapter.height(32),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${info['description']} >",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize:
                                                          ScreenAdapter.fs(38),
                                                      color: Colors.white60),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ))),
                        ],
                      )),
                ),
              ),
            )
          : SizedBox(
              width: ScreenAdapter.getScreenWidth(),
              height: ScreenAdapter.height(600),
            );
    });
  }
}
