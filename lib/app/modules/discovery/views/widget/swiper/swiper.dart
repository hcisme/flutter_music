import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmusic/app/modules/discovery/controllers/discovery_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';

class DiscoverySwiper extends GetView<DiscoveryController> {
  const DiscoverySwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.all(ScreenAdapter.width(16)),
        child: Swiper(
      itemCount: controller.swiperList.length,
      itemBuilder: (context, index) {
        return Container(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.all(ScreenAdapter.width(24)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenAdapter.width(20)),
          ),
          child: CachedNetworkImage(
            imageUrl: controller.swiperList[index].imageUrl,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
      },
      pagination: SwiperPagination(
          margin: const EdgeInsets.all(4.0),
          builder: SwiperCustomPagination(
              builder: (BuildContext context, SwiperPluginConfig config) {
            return ConstrainedBox(
              constraints:
                  BoxConstraints.expand(height: ScreenAdapter.height(50)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: const RectSwiperPaginationBuilder(
                        color: Colors.white,
                        activeColor: Colors.red,
                      ).build(context, config),
                    ),
                  )
                ],
              ),
            );
          })),
      autoplay: true,
      loop: true,
    ));
  }
}
