import 'package:cloudmusic/app/modules/mv/controllers/mv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MvAppbar extends GetView<MvController> {
  const MvAppbar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('MvView'),
      elevation: 0,
      backgroundColor: Colors.black.withOpacity(0.1),
      centerTitle: true,
    );
  }
}
