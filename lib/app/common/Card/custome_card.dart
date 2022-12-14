import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic/app/common/tip/tip.dart';
import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';

/// 自定义卡片
class CustomeCard extends StatelessWidget {
  final num? width;
  final num? height;
  final String coverImg;
  final String playCount;
  final String title;
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;

  const CustomeCard(
      {super.key,
      this.width = 280,
      this.height = 380,
      required this.coverImg,
      required this.playCount,
      required this.title,
      this.margin,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        width: ScreenAdapter.width(width!),
        height: ScreenAdapter.height(height!),
        margin: margin,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(6)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImage(
                      width: double.infinity,
                      height: ScreenAdapter.height(280),
                      fit: BoxFit.cover,
                      imageUrl: HttpsClient.getClipImg(coverImg)),
                ),
                Positioned(
                    top: ScreenAdapter.height(6),
                    right: ScreenAdapter.width(6),
                    child: SmallTip(playCount: playCount))
              ],
            ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: ScreenAdapter.fs(34)),
            )
          ],
        ),
      ),
    );
  }
}
