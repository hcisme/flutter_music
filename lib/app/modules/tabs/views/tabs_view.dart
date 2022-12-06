import 'package:cloudmusic/app/services/iconfont/iconfont.dart';
import 'package:cloudmusic/app/services/player/player.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Overlay.of(context)?.insert(_entry());
    });

    return Obx(() => Scaffold(
          body: PageView(
            // 配置左右滑动
            controller: controller.pageController,
            children: controller.pages,
            onPageChanged: (index) {
              // 滑动
              controller.changeCurrentPage(index);
            },
          ),
          bottomNavigationBar: SizedBox(
            height: ScreenAdapter.height(150),
            child: BottomNavigationBar(
              elevation: 0,
              iconSize: 17,
              selectedLabelStyle: const TextStyle(fontSize: 12),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              fixedColor: Colors.red,
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.currentIndex.value,
              onTap: (index) {
                // 点击
                controller.changeCurrentPage(index);
                controller.pageController.jumpToPage(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(IconFont.discovery), label: "发现"),
                BottomNavigationBarItem(
                    icon: Icon(IconFont.playlists), label: "歌单"),
                BottomNavigationBarItem(icon: Icon(IconFont.mvs), label: "MV"),
              ],
            ),
          ),
        ));
  }

  OverlayEntry _entry() {
    return OverlayEntry(builder: ((context) {
      return Positioned(
          width: 48,
          height: 48,
          bottom: 60,
          right: 5,
          child: Obx((() {
            return FloatingActionButton(
                onPressed: () {
                  controller.flag.value
                      ? Audio().pause()
                      : Audio().play(controller.url.value);
                },
                child: controller.flag.value
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow));
          })));
    }));
  }
}
