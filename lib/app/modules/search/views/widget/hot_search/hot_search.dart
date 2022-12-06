import 'package:cloudmusic/app/modules/search/controllers/serach_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HotSearch extends GetView<SerachController> {
  const HotSearch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenAdapter.width(32))),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: ScreenAdapter.height(100),
                  margin: EdgeInsets.only(left: ScreenAdapter.width(50)),
                  child: Text(
                    "热搜榜",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenAdapter.fs(46)),
                  ),
                ),
                IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      controller.getHotSearch();
                    },
                    icon: const Icon(Icons.refresh_sharp))
              ],
            ),
            const Divider(),
            Obx(() {
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenAdapter.width(40),
                    vertical: ScreenAdapter.width(20)),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.hotSearchList.length,
                itemBuilder: (BuildContext context, int i) {
                  var item = controller.hotSearchList[i];
                  return InkWell(
                    onTap: () async {
                      await controller.setData('s_list', item['searchWord']);
                      await controller.getData('s_list');
                      Get.toNamed('/result',
                          arguments: {'key': item['searchWord']});
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: ScreenAdapter.height(30)),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Container(
                            width: ScreenAdapter.width(100),
                            height: ScreenAdapter.height(50),
                            margin:
                                EdgeInsets.only(right: ScreenAdapter.width(20)),
                            alignment: Alignment.center,
                            child: Text(
                              "${i + 1}",
                              style: TextStyle(
                                  color: i == 0 || i == 1 || i == 2
                                      ? Colors.red
                                      : Colors.black87),
                            ),
                          ),
                          Text(
                            item['searchWord'],
                            style: TextStyle(
                                color: i != 0 && i != 1 && i != 2
                                    ? Colors.black54
                                    : Colors.black),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
