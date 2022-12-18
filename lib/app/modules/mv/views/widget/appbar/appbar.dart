import 'package:cloudmusic/app/modules/mv/controllers/mv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MvAppbar extends GetView<MvController> {
  const MvAppbar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppBar(
        title: Text(
            controller.detailInfo.isEmpty ? '' : controller.detailInfo['name']),
        elevation: 0,
      );
    });
  }
}
