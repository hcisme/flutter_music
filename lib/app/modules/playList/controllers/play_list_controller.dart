import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class PlayListController extends GetxController {
  HttpsClient httpsClient = HttpsClient();
  EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: false,
    controlFinishLoad: true,
  );
  int id = Get.arguments["playlistId"];
  List middleIcons = [
    {'icon': Icons.check_circle_outline_outlined, 'key': 'star', 'title': '收藏'},
    {'icon': Icons.message, 'key': 'msg', 'title': '54'},
    {'icon': Icons.share_outlined, 'key': 'share', 'title': '分享'}
  ];
  RxList songList = [].obs;
  RxMap detailInfo = {}.obs;
  RxMap commentInfo = {}.obs;
  RxInt page = 0.obs;
  RxInt limit = 18.obs;
  RxBool flag = false.obs;
  RxBool isHaveData = true.obs;

  Future getPageMusicList() async {
    if (!isHaveData.value) {
      return;
    }
    page.value += 1;
    print(page.value);
    var list = await httpsClient.get('/playlist/track/all', params: {
      'id': Get.arguments["playlistId"],
      'limit': limit,
      'offset': (page.value - 1) * limit.value
    });
    if (list == null) {
      isHaveData.value = false;
      return 0;
    }
    if (limit > list.data['songs'].length) {
      isHaveData.value = false;
      refreshController.finishLoad(IndicatorResult.noMore);
      return false;
    } else {
      songList.value = [...songList, ...list.data['songs']];
      return 1;
    }
  }

  request() async {
    EasyLoading.show();
    var detail = httpsClient
        .get('/playlist/detail', params: {'id': Get.arguments["playlistId"]});
    var comments = httpsClient.get('/comment/playlist',
        params: {'id': Get.arguments["playlistId"], 'limit': 40, 'offset': 0});

    List<dynamic> response = await Future.wait([detail, comments]);
    if (!response.every((value) => value == null)) {
      flag.value = true;
      detailInfo.value = response[0].data['playlist'];
      commentInfo.value = response[1].data;
      EasyLoading.dismiss();
      return true;
    }
    return false;
  }

  @override
  void onInit() {
    super.onInit();

    request();
    getPageMusicList();
  }

  @override
  void onClose() {
    super.onClose();
    EasyLoading.dismiss();
  }
}
