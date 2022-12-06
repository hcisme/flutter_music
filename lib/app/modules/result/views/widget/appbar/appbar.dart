import 'package:cloudmusic/app/modules/result/controllers/result_controller.dart';
import 'package:cloudmusic/app/modules/search/controllers/serach_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ResultAppbarView extends GetView<ResultController> {
  const ResultAppbarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: InkWell(
        onTap: () => Get.back(),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black87,
        ),
      ),
      title: Container(
        width: double.infinity,
        height: ScreenAdapter.height(96),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromRGBO(246, 246, 246, 1)),
        child: TextFormField(
          initialValue: '${Get.arguments['key']}',
          style: TextStyle(fontSize: ScreenAdapter.fs(40)),
          decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      // 无边框
                      borderSide: BorderSide.none))
              .copyWith(isDense: true),
          onFieldSubmitted: (newValue) async {
            if (newValue != '') {
              controller.key = newValue;
              await Get.find<SerachController>().setData('s_list', newValue);
              await Get.find<SerachController>().getData('s_list');
              controller.isHaveData.value = true;
              controller.page.value = 0;
              controller.total.value = 0;
              controller.resultList.value = [];
              controller.flag.value = false;
              controller.refreshController.resetFooter();
              controller.request();
            }
          },
        ),
      ),
      centerTitle: true,
    );
  }
}
