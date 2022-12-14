import 'package:cloudmusic/app/modules/result/views/widget/appbar/appbar.dart';
import 'package:cloudmusic/app/modules/result/views/widget/result_music/result_music_view.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:cloudmusic/app/services/size/size.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Unified.appBarHeight),
          child: const ResultAppbarView(),
        ),
        backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
        body: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(ScreenAdapter.height(145)),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leadingWidth: 0,
                leading: const Text(''),
                title: TabBar(
                  onTap: (value) {},
                  isScrollable: true,
                  controller: controller.tabController,
                  // 指示器
                  indicatorColor: Colors.red,
                  // 选中文字
                  labelColor: Colors.red,
                  // 选项卡宽度
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      child: Text("单曲"),
                    ),
                    Tab(
                      child: Text("歌单"),
                    ),
                    Tab(
                      child: Text("MV"),
                    ),
                    Tab(
                      child: Text("用户"),
                    ),
                    Tab(
                      child: Text("电台"),
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(controller: controller.tabController, children: [
              EasyRefresh.builder(
                controller: controller.refreshController,
                onLoad: () async {
                  controller.request().then((success) {
                    try {
                      if (success == 1) {
                        controller.refreshController.finishLoad();
                      } else if (success == 0) {
                        controller.refreshController
                            .finishLoad(IndicatorResult.fail);
                      }
                    } catch (e) {}
                  });
                },
                childBuilder: (BuildContext context, ScrollPhysics physics) {
                  return Obx(() {
                    return ListView(
                      physics: controller.resultList.isNotEmpty
                          ? physics
                          : const NeverScrollableScrollPhysics(),
                      children: const [ResultMusicView()],
                    );
                  });
                },
              ),
              ListView(
                children: const [Text('歌单')],
              ),
              ListView(
                children: const [Text('MV')],
              ),
              ListView(
                children: const [Text('用户')],
              ),
              ListView(
                children: const [Text('电台')],
              ),
            ])));
  }
}
