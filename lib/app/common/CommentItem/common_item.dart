import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic/app/services/iconfont/iconfont.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';

class CommonItem extends StatelessWidget {
  final String avatar;
  final String name;
  final bool isVip;
  final bool liked;
  final String publishTime;
  final String likedCount;
  final String content;

  const CommonItem(
      {super.key,
      required this.avatar,
      required this.name,
      required this.isVip,
      required this.publishTime,
      required this.likedCount,
      required this.content,
      required this.liked});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
              backgroundImage: CachedNetworkImageProvider(avatar),
            ),
            SizedBox(
              width: ScreenAdapter.width(32),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(name,
                          style: TextStyle(
                              fontSize: ScreenAdapter.fs(42),
                              color: Colors.black87)),
                      isVip
                          ? const Icon(
                              IconFont.vip,
                              color: Colors.red,
                            )
                          : const Text('')
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      publishTime,
                      style: TextStyle(
                          fontSize: ScreenAdapter.fs(32),
                          color: Colors.black38),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$likedCount ',
                    style: TextStyle(fontSize: ScreenAdapter.fs(38)),
                  ),
                  Icon(
                    IconFont.star,
                    color: liked ? Colors.red : Colors.black38,
                    size: ScreenAdapter.fs(64),
                  )
                ],
              ),
            )
          ],
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
              left: ScreenAdapter.width(150), top: ScreenAdapter.height(16)),
          // alignment: Alignment.topCenter,
          child: Text(
            content,
            style: TextStyle(fontSize: ScreenAdapter.fs(38)),
          ),
        )
      ],
    );
  }
}
