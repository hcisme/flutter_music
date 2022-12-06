import 'package:cloudmusic/app/modules/discovery/views/discovery_view.dart';
import 'package:cloudmusic/app/modules/mvs/views/mvs_view.dart';
import 'package:cloudmusic/app/modules/playLists/views/play_lists_view.dart';
import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:cloudmusic/app/services/keepAliveWrapper/keepAliveWrapper.dart';
import 'package:cloudmusic/app/services/player/player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabsController extends GetxController {
  HttpsClient httpsClient = HttpsClient();
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);
  final List<Widget> pages = const [
    KeepAliveWrapper(child: DiscoveryView()),
    PlayListsView(),
    MvsView(),
  ];
  RxBool flag = false.obs;
  RxString url = Audio.url.obs;

  void changeCurrentPage(index) {
    currentIndex.value = index;
  }

  getUrl(num id) async {
    var urlMapInfo = await httpsClient.get('/song/url', params: {"id": id});
    url.value = urlMapInfo.data["data"][0]["url"];
    print(urlMapInfo.data["data"][0]["url"]);
    await Audio().play(url.value);
  }

  @override
  void onInit() {
    super.onInit();

    Audio().getStatus();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
