import 'package:chewie/chewie.dart';
import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:cloudmusic/app/services/iconfont/iconfont.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class MvController extends GetxController {
  late final VideoPlayerController videoPlayerController;
  late final ChewieController chewieController;
  HttpsClient httpsClient = HttpsClient();
  int id = 0;
  List iconList = [
    {'icon': Icons.add_to_photos_sharp, 'title': '收藏'},
    {'icon': IconFont.share, 'title': '1388'},
    {'icon': IconFont.comment, 'title': '278'},
    {'icon': Icons.star, 'title': '1万'}
  ];
  RxString videoUrl = ''.obs;
  RxMap detailInfo = {}.obs;
  RxMap singer = {}.obs;
  RxList simiMvs = [].obs;

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
    await EasyLoading.showToast('网络似乎出问题了');
    return false;
  }

  @override
  void onInit() async {
    super.onInit();
    id = Get.arguments['mvId'];

    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..dismissOnTap = false
      ..maskType = EasyLoadingMaskType.none
      ..userInteractions = false
      ..indicatorType = EasyLoadingIndicatorType.wave;

    await request().then((value) {
      initVideoPlayer();
    });
  }

  @override
  void onClose() {
    super.onClose();

    EasyLoading.dismiss();

    videoPlayerController.dispose();
    chewieController.dispose();
  }
}
