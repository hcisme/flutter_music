import 'package:cloudmusic/app/modules/playList/controllers/play_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiddleBottomView extends GetView<PlayListController> {
  const MiddleBottomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return controller.songList.isEmpty
        ? const Text('')
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.centerLeft,
                child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.play_circle_sharp,
                            color: Colors.red,
                          ),
                        ),
                        const Text(
                          '播放全部',
                          style: TextStyle(),
                        ),
                        const Text('(205)')
                      ],
                    )),
              )),
              Expanded(
                  child: Wrap(
                alignment: WrapAlignment.end,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.file_download_outlined)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.menu_outlined)),
                ],
              ))
            ],
          );
  }
}
