import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mvs_controller.dart';

class MvsView extends GetView<MvsController> {
  const MvsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MvsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MvsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
