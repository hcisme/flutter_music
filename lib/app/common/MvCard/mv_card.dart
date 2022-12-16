import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic/app/services/format_timestamp/time_tool.dart';
import 'package:cloudmusic/app/services/iconfont/iconfont.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';

class CustomeMvCard extends StatelessWidget {
  final String picurl;
  final bool isMv;
  final String title;
  final num duration;
  final String artist;
  final num playCount;
  final Function()? onTap;

  const CustomeMvCard(
      {super.key,
      required this.picurl,
      required this.isMv,
      required this.title,
      required this.duration,
      required this.artist,
      required this.playCount,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(ScreenAdapter.width(8)),
      child: Container(
        width: ScreenAdapter.getScreenWidth(),
        height: ScreenAdapter.height(240),
        padding: EdgeInsets.symmetric(horizontal: ScreenAdapter.width(32)),
        child: Row(
          children: [
            // 图片
            Container(
              height: double.infinity,
              width: ScreenAdapter.width(340),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenAdapter.width(24))),
              margin: EdgeInsets.only(
                  right: ScreenAdapter.width(24),
                  top: ScreenAdapter.width(24),
                  bottom: ScreenAdapter.width(24)),
              child: CachedNetworkImage(
                imageUrl: picurl,
                fit: BoxFit.cover,
              ),
            ),
            // 右侧文字
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    isMv
                        ? Container(
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            child: Icon(
                              IconFont.mvs,
                              color: Colors.red,
                              size: ScreenAdapter.fs(48),
                            ),
                          )
                        : const Text(''),
                    Expanded(
                        child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: ScreenAdapter.fs(38)),
                    ))
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: ScreenAdapter.width(16),
                          bottom: ScreenAdapter.width(16),
                          right: ScreenAdapter.width(16)),
                      child: Text(
                        Tool.formatDt(duration),
                        style: TextStyle(
                            fontSize: ScreenAdapter.fs(32),
                            color: Colors.black54),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(
                          top: ScreenAdapter.width(16),
                          bottom: ScreenAdapter.width(16),
                          right: ScreenAdapter.width(16)),
                      child: Text(
                        artist,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: ScreenAdapter.fs(32),
                            color: Colors.black54),
                      ),
                    )),
                    Row(
                      children: [
                        Icon(
                          Icons.play_circle_outline_outlined,
                          size: ScreenAdapter.fs(42),
                          color: Colors.black54,
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: ScreenAdapter.width(4)),
                          child: Text(
                            Tool.formatPlayCount(playCount),
                            style: TextStyle(fontSize: ScreenAdapter.fs(34)),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
