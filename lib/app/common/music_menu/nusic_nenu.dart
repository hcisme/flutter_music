import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicMenu extends StatelessWidget {
  const MusicMenu({super.key});

  static slideBottomMenu(id,
      {required String picUrl,
      required String name,
      required String singer,
      required String albumn}) {
    Get.bottomSheet(Container(
      height: ScreenAdapter.getScreenHeight(),
      padding: EdgeInsets.all(ScreenAdapter.height(32)),
      decoration: BoxDecoration(
          color: Colors.white,
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
                width:
                    ScreenAdapter.getScreenWidth() - ScreenAdapter.width(320),
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
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: ScreenAdapter.width(24),
                        right: ScreenAdapter.width(24),
                        bottom: ScreenAdapter.width(24)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.headphones_outlined,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: ScreenAdapter.width(32),
                        ),
                        const Text(
                          '赞赏歌曲',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
