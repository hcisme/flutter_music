import 'package:cloudmusic/app/modules/playList/controllers/play_list_controller.dart';
import 'package:get/get.dart';

class PlayListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayListController>(
      () => PlayListController(),
    );
  }
}
