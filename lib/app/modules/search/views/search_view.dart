import 'package:cloudmusic/app/modules/search/views/widget/appbar/appbar.dart';
import 'package:cloudmusic/app/modules/search/views/widget/guess_you_search/guess_you_search.dart';
import 'package:cloudmusic/app/modules/search/views/widget/history/search_history_view.dart';
import 'package:cloudmusic/app/modules/search/views/widget/hot_search/hot_search.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:cloudmusic/app/services/size/size.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/serach_controller.dart';

class SerachView extends GetView<SerachController> {
  const SerachView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Unified.appBarHeight),
          child: const SearchAppBarView(),
        ),
        backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
        body: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenAdapter.height(30),
              vertical: ScreenAdapter.height(5)),
          children: const [
            SearchHistoryView(),
            SizedBox(height: 20),
            GuessYouSearch(),
            SizedBox(height: 40),
            HotSearch(),
            SizedBox(height: 20),
          ],
        ));
  }
}
