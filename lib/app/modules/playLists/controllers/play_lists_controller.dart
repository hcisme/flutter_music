import 'package:cloudmusic/app/services/enum/data.dart';
import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class PlayListsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  HttpsClient httpsClient = HttpsClient();
  EasyRefreshController easyRefreshController = EasyRefreshController();
  ScrollController scrollController = ScrollController();
  final EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  late final TabController tabController;
  RxString cat = '全部'.obs;
  List<String> tabs = [
    '全部',
    '欧美',
    '华语',
    '说唱',
    '流行',
    '摇滚',
    '民谣',
    '电子',
    '轻音乐',
    '影视原声',
    'ACG',
    '怀旧',
    '治愈',
    '旅行',
    '123'
  ];
  int limit = 21;
  int page = 0;
  int offset = 0;
  RxList playList = [].obs;
  bool flag = true;

  initLoading() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..dismissOnTap = false
      ..maskType = EasyLoadingMaskType.none
      ..userInteractions = true
      ..indicatorType = EasyLoadingIndicatorType.wave;
  }

  resetPagination() {
    easyRefreshController.resetFooter();
    page = 0;
    offset = 0;
    flag = true;
    playList.value = [];
  }

  Future<DataStatus> request() async {
    if (flag) {
      flag = false;
      EasyLoading.show();
      page++;
      var response = await httpsClient.get('/top/playlist',
          cache: true,
          params: {
            'limit': limit,
            'offset': (page - 1) * limit,
            'cat': cat.value
          });
      if (response != null) {
        playList.value = [...playList, ...response.data['playlists']];
        flag = response.data['more'];
        EasyLoading.dismiss();
        return DataStatus.SUCCESS;
      }
      await EasyLoading.showToast('网络似乎出问题了');
      return DataStatus.FAIL;
    }
    return DataStatus.NODATA;
  }

  @override
  void onInit() {
    super.onInit();
    initLoading();
    tabController = TabController(length: tabs.length, vsync: this);

    request();

    ever(cat, (callback) async {
      resetPagination();
      await scrollController.animateTo(0,
          curve: Curves.ease, duration: const Duration(milliseconds: 300));
      await request();
    });
  }

  @override
  void onClose() {
    super.onClose();
    EasyLoading.dismiss();
  }
}
