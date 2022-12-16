import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic/app/modules/discovery/controllers/discovery_controller.dart';
import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:cloudmusic/app/services/iconfont/iconfont.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import 'package:get/get.dart';

class AllListenView extends GetView<DiscoveryController> {
  const AllListenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenAdapter.getScreenWidth(),
        height: ScreenAdapter.height(770),
        margin: EdgeInsets.only(
          top: ScreenAdapter.height(24),
          left: ScreenAdapter.width(16),
          right: ScreenAdapter.width(16),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: ScreenAdapter.height(16)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.refresh_outlined,
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(8),
                  ),
                  Text(
                    "大家都在听",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenAdapter.fs(48)),
                  ),
                ],
              ),
            ),
            SizedBox(
                width: ScreenAdapter.getScreenWidth(),
                height: ScreenAdapter.height(670),
                child: Obx(() {
                  return Swiper(
                    loop: false,
                    itemCount: controller.allListenSongs.length ~/ 3,
                    itemBuilder: (context, index) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: ((context, i) {
                            var item = controller.allListenSongs[index * 3 + i];
                            return InkWell(
                              onTap: () {
                                controller.getUrl(item["id"]);
                              },
                              borderRadius:
                                  BorderRadius.circular(ScreenAdapter.width(8)),
                              child: ListTile(
                                  leading: Container(
                                    width: ScreenAdapter.width(140),
                                    height: ScreenAdapter.height(140),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            ScreenAdapter.width(12))),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: HttpsClient.getClipImg(
                                          item['picUrl']),
                                    ),
                                  ),
                                  title: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: ScreenAdapter.width(400),
                                        child: Text(item['name'],
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: ScreenAdapter.fs(42),
                                                fontWeight: FontWeight.w400,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "-${item["song"]['artists']?.map((row) => row['name']).join(' / ')}",
                                          style: TextStyle(
                                              fontSize: ScreenAdapter.fs(34),
                                              color: Colors.black54,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      )
                                    ],
                                  ),
                                  subtitle: Text(
                                      item["song"]["alias"]
                                          .map((item) => item)
                                          .join(' / '),
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.fs(34),
                                          fontWeight: FontWeight.w400)),
                                  trailing: item['song']['mvid'] != 0
                                      ? IconButton(
                                          onPressed: () {
                                            Get.toNamed('/mv', arguments: {
                                              'mvId': item['song']['mvid']
                                            });
                                          },
                                          icon: Icon(
                                            IconFont.mvs,
                                            size: ScreenAdapter.fs(54),
                                          ),
                                        )
                                      : const Text('')),
                            );
                          }));
                    },
                  );
                })),
          ],
        ));
  }
}
