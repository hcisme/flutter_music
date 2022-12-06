import 'package:cloudmusic/app/modules/mv/views/widget/mv_info/mv_info_view.dart';
import 'package:cloudmusic/app/modules/mv/views/widget/mv_player/mv_player_view.dart';
import 'package:cloudmusic/app/modules/mv/views/widget/related_recom/related_recom_view.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mv_controller.dart';

class MvView extends GetView<MvController> {
  const MvView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MvPlayerView(),
          Container(
            height: ScreenAdapter.getScreenHeight() - ScreenAdapter.height(900),
            padding: EdgeInsets.all(ScreenAdapter.width(24)),
            child: ListView(
              children: const [MvInfoView(), Divider(), RelatedRecomView()],
            ),
          )
        ],
      ),
    );
  }
}
