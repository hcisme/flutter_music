import 'package:chewie/chewie.dart';
import 'package:cloudmusic/app/services/enum/data.dart';
import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class MvController extends GetxController {
  late final VideoPlayerController videoPlayerController;
  late final ChewieController chewieController;
  EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: false,
    controlFinishLoad: true,
  );
  HttpsClient httpsClient = HttpsClient();
  int id = 0;
  RxString videoUrl = ''.obs;
  RxMap detailInfo = {}.obs;
  RxMap singer = {}.obs;
  RxList simiMvs = [].obs;

  // 评论数据
  RxInt mostNew = 0.obs;
  int page = 0;
  int limit = 50;
  bool isHaveData = true;
  RxInt commentTotal = 0.obs;
  RxList newComments = [].obs;
  RxList hotComments = [].obs;

  initVideoPlayer() {
    videoPlayerController = VideoPlayerController.network(videoUrl.value);

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: ScreenAdapter.getScreenWidth() / ScreenAdapter.height(600),
      autoPlay: true,
      // looping: true,
      optionsBuilder: (context, defaultOptions) async {
        await showDialog<void>(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              content: ListView.builder(
                itemCount: defaultOptions.length,
                itemBuilder: (_, i) => ActionChip(
                  label: Text(defaultOptions[i].title),
                  onPressed: () => defaultOptions[i].onTap!(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  getSingerInfo(id) async {
    var singerInfo =
        await httpsClient.get('/artist/follow/count', params: {'id': id});
    singer.value = singerInfo.data['data'];
  }

  Future request() async {
    EasyLoading.show();
    var mvLink = httpsClient.get('/mv/url', params: {'id': id});
    var detail = httpsClient.get('/mv/detail', params: {'mvid': id});
    var simiMv = httpsClient.get('/simi/mv', params: {'mvid': id});

    List<dynamic> response = await Future.wait([mvLink, detail, simiMv]);
    if (!response.every((value) => value == null)) {
      getSingerInfo(response[1].data['data']['artists'][0]['id']);
      videoUrl.value =
          'https${response[0].data['data']['url'].split("http")[1]}';
      detailInfo.value = response[1].data['data'];
      simiMvs.value = response[2].data['mvs'];
      EasyLoading.dismiss();
      return true;
    }
    return false;
  }

  getAllComments() async {
    if (!isHaveData) {
      return DataStatus.NODATA;
    }
    EasyLoading.show();
    page++;
    var response = await httpsClient.get('/comment/mv', params: {
      'id': id,
      'limit': limit,
      'offset': (page - 1) * limit,
      'before': page > 1 ? newComments[newComments.length - 1]['time'] : null
    });

    if (response != null) {
      if (!response.data['more']) {
        isHaveData = false;
        return DataStatus.NODATA;
      }
      newComments.value = [...newComments, ...response.data['comments']];
      if (page == 1) {
        hotComments.value = response.data['hotComments'];
        commentTotal.value = response.data['total'];
      }
      EasyLoading.dismiss();
      return DataStatus.SUCCESS;
    }
    return DataStatus.FAIL;
  }

  checkType(int type) {
    refreshController.resetFooter();
    mostNew.value = type;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    id = Get.arguments['mvId'];

    await request().then((value) {
      initVideoPlayer();
    });
  }

  @override
  void onClose() {
    super.onClose();

    EasyLoading.dismiss();
    refreshController.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }
}
