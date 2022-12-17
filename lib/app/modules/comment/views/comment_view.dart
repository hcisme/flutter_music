import 'package:cloudmusic/app/modules/comment/views/widget/appbar/comment_appbar.dart';
import 'package:cloudmusic/app/modules/comment/views/widget/checkout/checkout.dart';
import 'package:cloudmusic/app/modules/comment/views/widget/comment_list/CommonList.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:cloudmusic/app/services/size/size.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/comment_controller.dart';

class CommentView extends GetView<CommentController> {
  const CommentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Unified.appBarHeight * 2),
          child: const CommentAppBar(),
        ),
        body: Column(
          children: [
            SizedBox(
              height: ScreenAdapter.height(24),
            ),
            const CommentCheckout(),
            const CommentList()
          ],
        ));
  }
}
