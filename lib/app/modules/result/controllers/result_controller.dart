import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ResultController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  TextEditingController textEditingController = TextEditingController();
  HttpsClient httpsClient = HttpsClient();
  String key = Get.arguments['key'];
  late final EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: false,
    controlFinishLoad: true,
  );

  RxString status = ''.obs;
  RxInt page = 0.obs;
  RxInt type = 1.obs;
  RxInt limit = 25.obs;
  RxList resultList = [].obs;
  RxInt total = 0.obs;
  RxBool flag = false.obs;
  RxBool isHaveData = true.obs;
  RxInt commentCount = 0.obs;

  Future request() async {
    // 首次加载显示 loading
    if (flag.value == false) {
      flag.value = true;
      EasyLoading.show(
        status: '加载中...',
      );
    }
    if (!isHaveData.value) {
      return;
    }
    page.value += 1;
    var list = httpsClient.get('/cloudsearch', params: {
      'keywords': key,
      'type': type.value,
      'limit': limit.value,
      'offset': (page.value - 1) * limit.value
    });

    List<dynamic> response = await Future.wait([list]);
    if (!response.every((value) => value == null)) {
      // 没有数据时总数会变 为 0
      if (resultList.length > response[0].data["result"]["songCount"]) {
        isHaveData.value = false;
        refreshController.finishLoad(IndicatorResult.noMore);
        return;
      } else {
        status.value = '没有更多音乐了哟';
        EasyLoading.dismiss();
        resultList.value = [
          ...resultList,
          ...(response[0].data["result"]["songs"] ?? [])
        ];
        total.value = response[0].data["result"]["songCount"];
        return 1;
      }
    }
    return 0;
  }

  Future getCommentCount(id) async {
    var response =
        await httpsClient.get('/comment/music', params: {'id': id, 'limit': 1});
    commentCount.value = response.data['total'];
  }

  @override
  void onInit() {
    super.onInit();
    textEditingController.text = Get.arguments['key'];

    tabController = TabController(
      length: 5,
      vsync: this,
    );

    request();
  }

  @override
  void onClose() {
    super.onClose();

    // 销毁
    tabController.dispose();
    // 取消loading
    EasyLoading.dismiss();
  }
}
