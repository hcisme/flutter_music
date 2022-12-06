import 'package:get/get.dart';

import '../controllers/mv_controller.dart';

class MvBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MvController>(
      () => MvController(),
    );
  }
}
