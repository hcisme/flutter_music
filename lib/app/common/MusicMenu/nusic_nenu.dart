import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic/app/common/MusicMenu/menu_item/menu_item.dart';
import 'package:cloudmusic/app/services/iconfont/iconfont.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicMenu extends StatelessWidget {
  const MusicMenu({super.key});

  static slideBottomMenu(id,
      {required String picUrl,
      required String name,
      required String singer,
      required String albumn,
      required String alia,
      required String commentCount}) {
    Get.bottomSheet(
        Container(
          height: ScreenAdapter.getScreenHeight(),
          padding: EdgeInsets.all(ScreenAdapter.height(32)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ScreenAdapter.height(80)),
                  topRight: Radius.circular(ScreenAdapter.height(80)))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: ScreenAdapter.width(180),
                    height: ScreenAdapter.height(180),
                    margin: EdgeInsets.all(ScreenAdapter.width(16)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ScreenAdapter.width(32))),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: picUrl,
                    ),
                  ),
                  Container(
                    width: ScreenAdapter.getScreenWidth() -
                        ScreenAdapter.width(320),
                    height: ScreenAdapter.height(180),
                    margin: EdgeInsets.all(ScreenAdapter.width(16)),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '歌曲：$name',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: ScreenAdapter.fs(48),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                            child: Text(singer,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: ScreenAdapter.fs(36),
                                    color: Colors.black54)))
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                ' 开通VIP享高品质听觉盛宴',
                style: TextStyle(
                    fontSize: ScreenAdapter.fs(34), color: Colors.black45),
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    const MusicMenuItem(
                      icon: Icons.play_circle_outline,
                      title: '下一首播放',
                    ),
                    const MusicMenuItem(
                      icon: Icons.play_circle_outline,
                      title: '收藏到歌单',
                    ),
                    const MusicMenuItem(
                      icon: Icons.downloading_outlined,
                      title: '下载',
                    ),
                    MusicMenuItem(
                      icon: IconFont.comment,
                      title: '评论($commentCount)',
                      onTap: () {
                        Get.back();
                        Get.toNamed('/comment', arguments: {
                          'id': id,
                          'picUrl': picUrl,
                          'name': name,
                          'singer': singer,
                          'commentCount': commentCount,
                          'alia': alia
                        });
                      },
                    ),
                    const MusicMenuItem(
                      icon: IconFont.share,
                      title: '分享',
                    ),
                    MusicMenuItem(
                      icon: Icons.person_outline_rounded,
                      title: '歌手：$singer',
                    ),
                    const MusicMenuItem(
                      icon: Icons.people_alt_outlined,
                      title: '创作者',
                    ),
                    MusicMenuItem(
                      icon: IconFont.ablum,
                      title: '专辑：$albumn',
                    ),
                    const MusicMenuItem(
                      icon: Icons.subtitles_off_sharp,
                      title: '屏蔽歌曲或歌手',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
