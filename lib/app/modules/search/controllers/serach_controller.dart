import 'package:cloudmusic/app/services/httpClient/httpsClient.dart';
import 'package:cloudmusic/app/services/storage/storage.dart';
import 'package:get/get.dart';

class SerachController extends GetxController {
  HttpsClient httpsClient = HttpsClient();
  RxString keyWord = ''.obs;
  RxList hotSearchList = [].obs;
  RxList historyList = [].obs;
  RxBool isShowCloseBtn = false.obs;

  getHotSearch() async {
    var response = await httpsClient.get('/search/hot/detail');
    if (response != null) {
      hotSearchList.value = response.data['data'];
    }
  }

  setData(String key, dynamic value) async {
    var _setList = Set();
    if (await Storage.getData(key) != null) {
      var newData = [...await Storage.getData(key), value];
      _setList.addAll(newData);
      Storage.setData(key, _setList.toList());
    } else {
      Storage.setData(key, [value]);
    }
  }

  getData(String key) async {
    if (await Storage.getData(key) != null) {
      historyList.value =
          (await Storage.getData(key) as List).reversed.toList();
    } else {
      historyList.value = [];
    }
    update();
  }

  deleteItem(String key, String item) async {
    List list = await Storage.getData(key);
    list.remove(item);
    await Storage.setData(key, list);
    await getData(key);
  }

  @override
  void onInit() {
    super.onInit();

    getHotSearch();
    getData('s_list');

    // Storage.clear();
  }

  @override
  void onClose() {
    super.onClose();

    isShowCloseBtn.value = false;
  }
}
