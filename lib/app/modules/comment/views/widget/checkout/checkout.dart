import 'package:cloudmusic/app/modules/comment/controllers/comment_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentCheckout extends GetView<CommentController> {
  const CommentCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenAdapter.getScreenWidth(),
        color: Colors.white,
        padding: EdgeInsets.all(ScreenAdapter.width(32)),
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('评论区'),
              Expanded(
                  child: Wrap(
                alignment: WrapAlignment.end,
                spacing: ScreenAdapter.width(32),
                children: [
                  InkWell(
                    onTap: () {
                      controller.checkType(0);
                    },
                    child: Text(
                      '最新',
                      style: TextStyle(
                          fontWeight: controller.mostNew.value == 0
                              ? FontWeight.bold
                              : null),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.checkType(1);
                    },
                    child: Text(
                      '最热',
                      style: TextStyle(
                          fontWeight: controller.mostNew.value == 1
                              ? FontWeight.bold
                              : null),
                    ),
                  ),
                ],
              ))
            ],
          );
        }));
  }
}
