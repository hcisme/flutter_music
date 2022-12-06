import 'package:cloudmusic/app/modules/search/controllers/serach_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class GuessYouSearch extends GetView<SerachController> {
  const GuessYouSearch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "推荐",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: ScreenAdapter.fs(42)),
          ),
          IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {},
              icon: const Icon(Icons.refresh_outlined))
        ],
      ),
    ]);
  }
}
