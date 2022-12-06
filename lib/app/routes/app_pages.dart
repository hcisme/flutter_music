import 'package:flutter/animation.dart';

import 'package:get/get.dart';

import '../modules/mv/bindings/mv_binding.dart';
import '../modules/mv/views/mv_view.dart';
import '../modules/playList/bindings/play_list_binding.dart';
import '../modules/playList/views/play_list_view.dart';
import '../modules/result/bindings/result_binding.dart';
import '../modules/result/views/result_view.dart';
import '../modules/search/bindings/serach_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/tabs/bindings/tabs_binding.dart';
import '../modules/tabs/views/tabs_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.TABS;

  static final routes = [
    GetPage(
      name: _Paths.TABS,
      page: () => const TabsView(),
      binding: TabsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SerachView(),
      binding: SerachBinding(),
    ),
    GetPage(
      name: _Paths.RESULT,
      page: () => const ResultView(),
      binding: ResultBinding(),
    ),
    GetPage(
        name: _Paths.PLAY_LIST,
        page: () => const PlayListView(),
        binding: PlayListBinding(),
        curve: Curves.fastLinearToSlowEaseIn,
        transition: Transition.downToUp),
    GetPage(
        name: _Paths.MV,
        page: () => const MvView(),
        binding: MvBinding(),
        curve: Curves.fastLinearToSlowEaseIn,
        transition: Transition.downToUp),
  ];
}
