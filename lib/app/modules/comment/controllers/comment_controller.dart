import 'package:cloudmusic/app/services/enum/data.dart';
import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  HttpsClient httpsClient = HttpsClient();
  EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: false,
    controlFinishLoad: true,
  );
  RxInt mostNew = 0.obs;
  int page = 0;
  int limit = 50;
  bool isHaveData = true;

  RxList newComments = [].obs;
  RxList hotComments = [].obs;
  RxList renderComments = [].obs;

  Future<DataStatus> getAllComments() async {
    if (!isHaveData || mostNew.value == 1) {
      return DataStatus.NODATA;
    }
    EasyLoading.show();
    page++;
    var response = await httpsClient.get('/comment/music', params: {
      'id': Get.arguments['id'],
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
      renderComments.value = [...newComments, ...response.data['comments']];
      if (page == 1) {
        hotComments.value = response.data['hotComments'];
      }
      EasyLoading.dismiss();
      return DataStatus.SUCCESS;
    }
    return DataStatus.FAIL;
  }

  checkType(int type) {
    refreshController.resetFooter();
    renderComments.value = type == 0 ? newComments : hotComments;
    mostNew.value = type;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAllComments();
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
    EasyLoading.dismiss();
  }
}
