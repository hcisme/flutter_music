import 'package:cloudmusic/app/models/discovery/swiper.dart';
import 'package:cloudmusic/app/modules/tabs/controllers/tabs_controller.dart';
import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:cloudmusic/app/services/iconfont/iconfont.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoveryController extends GetxController {
  HttpsClient httpsClient = HttpsClient();
  final ScrollController scrollController = ScrollController();
  final EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: false,
  );
  // swiper
  RxDouble opacity = 0.0.obs;
  RxList<SwiperResult> swiperList = <SwiperResult>[].obs;
  RxList playlists = [].obs;
  RxList allListenSongs = [].obs;
  RxMap searchSuggest = {}.obs;
  RxList mvList = [].obs;
  RxBool flag = false.obs;

  // category
  List cateGoryList = [
    {'id': 1, 'title': '每日推荐', 'icon': Icons.calendar_month},
    {'id': 2, 'title': '私人FM', 'icon': Icons.radio},
    {'id': 3, 'title': '歌单', 'icon': Icons.queue_music},
    {'id': 4, 'title': '排行榜', 'icon': IconFont.rank},
    {'id': 5, 'title': '一歌一遇', 'icon': IconFont.listenMusic},
    {'id': 6, 'title': '数字专辑', 'icon': IconFont.ablum},
    {'id': 7, 'title': '有声书', 'icon': IconFont.songBook},
    {'id': 8, 'title': '关注新歌', 'icon': Icons.book_outlined},
    {'id': 9, 'title': '直播', 'icon': Icons.live_tv_rounded},
    {'id': 10, 'title': '游戏专区', 'icon': Icons.games},
  ];

  void addScrollEvenLister() {
    scrollController.addListener(() {
      if (scrollController.position.pixels <= 100) {
        opacity.value = scrollController.position.pixels / 100;
        if (opacity.value > 0.858) {
          opacity.value = 1;
        }
        update();
      }
    });
  }

  Future<bool> request() async {
    flag.value = false;
    var suggest = httpsClient.get('/search/default');
    var banners = httpsClient.get('/banner');
    var recommandPlaylist =
        httpsClient.get('/personalized', params: {"limit": 6});
    var allListenSong =
        httpsClient.get('/personalized/newsong', params: {"limit": 9});
    var mvs = httpsClient.get('/mv/all', params: {
      "limit": 10,
      'offset': 0,
      'area': '全部',
      'type': '全部',
      'order': '最热'
    });

    List<dynamic> response = await Future.wait(
        [banners, recommandPlaylist, allListenSong, suggest, mvs]);
    if (!response.every((value) => value == null)) {
      flag.value = true;
      // 轮播图
      var swipers = SwiperModel.fromJson(response[0].data);
      swiperList.value = swipers.banners;
      playlists.value = response[1].data['result'];
      allListenSongs.value = response[2].data['result'];
      searchSuggest.value = response[3].data['data'];
      mvList.value = response[4].data['data'];
      return true;
    }
    return false;
  }

  getUrl(num id) async {
    Get.find<TabsController>().getUrl(id);
  }

  @override
  void onInit() {
    super.onInit();

    addScrollEvenLister();

    request();
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }
}
