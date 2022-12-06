import 'package:cloudmusic/app/modules/search/controllers/serach_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchAppBarView extends GetView<SerachController> {
  const SearchAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
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
          child: TextField(
            // 修改搜索框字体
            scrollPadding: const EdgeInsets.all(0),
            style: TextStyle(fontSize: ScreenAdapter.fs(40)),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(right: ScreenAdapter.width(40)),
                hintText: Get.arguments['keyWord'],
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black54,
                  size: ScreenAdapter.fs(56),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    // 无边框
                    borderSide: BorderSide.none)),
            onChanged: (value) {
              controller.keyWord.value = value.trim();
            },
            onSubmitted: (value) async {
              if (value != "") {
                await controller.setData('s_list', value);
                await controller.getData('s_list');
                Get.toNamed('/result', arguments: {'key': value});
              }
            },
          )),
      actions: [
        TextButton(
          child: Text(
            "搜索",
            style: TextStyle(
                fontSize: ScreenAdapter.fs(36), color: Colors.black54),
          ),
          onPressed: () async {
            if (controller.keyWord.value != '') {
              await controller.setData('s_list', controller.keyWord.value);
              await controller.getData('s_list');
              Get.toNamed('/result',
                  arguments: {'key': controller.keyWord.value});
            }
          },
        )
      ],
    );
  }
}
