import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/play_lists_controller.dart';

class PlayListsView extends GetView<PlayListsController> {
  const PlayListsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PlayListsView'),
          centerTitle: true,
        ),
        body: ListView(
          children: List.generate(100, (index) => Text("$index")).toList(),
        ));
  }
}
