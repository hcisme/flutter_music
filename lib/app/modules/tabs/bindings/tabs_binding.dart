import 'package:get/get.dart';
import '../controllers/tabs_controller.dart';
import 'package:cloudmusic/app/modules/discovery/controllers/discovery_controller.dart';
import 'package:cloudmusic/app/modules/mvs/controllers/mvs_controller.dart';
import 'package:cloudmusic/app/modules/playLists/controllers/play_lists_controller.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsController>(
      () => TabsController(),
    );
    Get.lazyPut<DiscoveryController>(
      () => DiscoveryController(),
    );
    Get.lazyPut<PlayListsController>(
      () => PlayListsController(),
    );
    Get.lazyPut<MvsController>(
      () => MvsController(),
    );
  }
}
