import 'package:cloudmusic/app/modules/search/controllers/serach_controller.dart';
import 'package:cloudmusic/app/services/format_timestamp/time_tool.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:cloudmusic/app/services/storage/storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SearchHistoryView extends GetView<SerachController> {
  const SearchHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "历史",
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: ScreenAdapter.fs(42)),
            ),
            IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  if (controller.historyList.isEmpty) {
                    return;
                  }
                  Get.bottomSheet(Container(
                    padding: EdgeInsets.all(ScreenAdapter.width(20)),
                    color: Colors.white,
                    width: ScreenAdapter.getScreenWidth(),
                    height: ScreenAdapter.height(360),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "您确定清空吗",
                              style: TextStyle(fontSize: ScreenAdapter.fs(48)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenAdapter.height(40),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: const Text("取消")),
                            ElevatedButton(
                              onPressed: () async {
                                await Storage.remove('s_list');
                                await controller.getData('s_list');
                                Get.back();
                              },
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue)),
                              child: const Text("确定"),
                            )
                          ],
                        )
                      ],
                    ),
                  ));
                },
                icon: const Icon(Icons.delete_outline_sharp))
          ],
        ),
        Obx(() {
          return Wrap(
              children: controller.historyList.isNotEmpty
                  ? controller.historyList.map((item) {
                      return GestureDetector(
                        onLongPress: () {
                          Tool.closeKeyBoard(context);
                          controller.isShowCloseBtn.value = true;
                          Future.delayed(const Duration(seconds: 10), () {
                            controller.isShowCloseBtn.value = false;
                          });
                        },
                        onTap: () async {
                          controller.isShowCloseBtn.value = false;
                          await controller.setData('s_list', item);
                          await controller.getData('s_list');
                          Get.toNamed('/result', arguments: {'key': item});
                        },
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenAdapter.height(32),
                                  right: ScreenAdapter.height(32)),
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenAdapter.height(32),
                                vertical: ScreenAdapter.height(16),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      ScreenAdapter.width(40))),
                              child: Text(
                                item,
                                style: TextStyle(
                                    fontSize: ScreenAdapter.fs(38),
                                    color: Colors.black87),
                              ),
                            ),
                            controller.isShowCloseBtn.value
                                ? Positioned(
                                    top: ScreenAdapter.height(20),
                                    right: ScreenAdapter.height(20),
                                    child: InkWell(
                                      onTap: () {
                                        controller.deleteItem('s_list', item);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                246, 246, 246, 1),
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                        child: Icon(
                                          Icons.close,
                                          size: ScreenAdapter.fs(44),
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ))
                                : const Text('')
                          ],
                        ),
                      );
                    }).toList()
                  : [const Text('')]);
        })
      ],
    );
  }
}
