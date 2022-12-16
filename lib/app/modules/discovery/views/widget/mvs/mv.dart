import 'package:cloudmusic/app/common/MvCard/mv_card.dart';
import 'package:cloudmusic/app/modules/discovery/controllers/discovery_controller.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';

class DiscoveryMvView extends GetView<DiscoveryController> {
  const DiscoveryMvView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ScreenAdapter.getScreenWidth(),
        child: Obx(() {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenAdapter.width(32),
                    vertical: ScreenAdapter.height(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: ScreenAdapter.height(16)),
                      child: Text(
                        "发现mv",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenAdapter.fs(48)),
                      ),
                    ),
                    Container(
                      height: ScreenAdapter.height(80),
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: ScreenAdapter.width(40),
                          right: ScreenAdapter.width(40)),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black12.withOpacity(0.1)),
                          borderRadius:
                              BorderRadius.circular(ScreenAdapter.width(40))),
                      child: Text(
                        "更多 >",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: ScreenAdapter.fs(38)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: controller.mvList.map((item) {
                    return CustomeMvCard(
                        onTap: () {
                          Get.toNamed('/mv', arguments: {'mvId': item['id']});
                        },
                        picurl: item['cover'],
                        isMv: item['id'] != 0 || item['id'] != null,
                        title: item['name'],
                        duration: item['duration'],
                        artist:
                            item['artists'].map((row) => row['name']).join('/'),
                        playCount: item['playCount']);
                  }).toList(),
                ),
              ),
            ],
          );
        }));
  }
}
