import 'package:cloudmusic/app/modules/discovery/views/widget/all_listen_song/all_listen_view.dart';
import 'package:cloudmusic/app/modules/discovery/views/widget/cate_gory/cate_gory_view.dart';
import 'package:cloudmusic/app/modules/discovery/views/widget/discovery_appbar/discovery_appbar.dart';
import 'package:cloudmusic/app/modules/discovery/views/widget/mvs/mv.dart';
import 'package:cloudmusic/app/modules/discovery/views/widget/recom_playlist/recom_play_list_view.dart';
import 'package:cloudmusic/app/modules/discovery/views/widget/swiper/swiper.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:cloudmusic/app/services/size/size.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/discovery_controller.dart';

class DiscoveryView extends GetView<DiscoveryController> {
  const DiscoveryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Unified.appBarHeight),
        child: const DiscoveryAppBar(),
      ),
      body: EasyRefresh.builder(
        controller: controller.refreshController,
        header: const ClassicHeader(
          dragText: '下拉刷新',
          armedText: '释放开始',
          readyText: '刷新中...',
          processingText: '刷新中...',
          processedText: '刷新成功',
          noMoreText: '没有更多',
          failedText: '刷新失败',
          messageText: '最后更新于 %T',
        ),
        onRefresh: () async {
          controller.request().then((success) {
            if (success) {
              controller.refreshController.finishRefresh();
            } else {
              controller.refreshController.finishRefresh(IndicatorResult.fail);
            }
          });
        },
        childBuilder: (BuildContext context, ScrollPhysics physics) {
          return ListView(
            physics: physics,
            children: [
              /// 防止轮播图切换导致下拉刷新轮播图数据不更新
              AnimatedContainer(
                width: ScreenAdapter.getScreenWidth(),
                height: ScreenAdapter.height(420),
                duration: const Duration(milliseconds: 300),
                child: Obx((() => controller.flag.value
                    ? const DiscoverySwiper()
                    : const Text(''))),
              ),
              const CateGoryView(),
              const Divider(),
              const RecomPlayListView(),
              const Divider(),
              const AllListenView(),
              const Divider(),
              const DiscoveryMvView(),
            ],
          );
        },
      ),
    );
  }
}
