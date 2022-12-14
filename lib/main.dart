import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  /// 配置透明状态栏
  SystemUiOverlayStyle systemUiOverlayStyle =
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  // 全局设置
  EasyRefresh.defaultHeaderBuilder = () => const ClassicHeader(
        dragText: '下拉刷新',
        armedText: '释放开始',
        readyText: '刷新中...',
        processingText: '刷新中...',
        processedText: '刷新成功',
        noMoreText: '没有更多',
        failedText: '刷新失败',
        messageText: '最后更新于 %T',
      );
  EasyRefresh.defaultFooterBuilder = () => const ClassicFooter(
        readyText: '加载中...',
        processingText: '加载中...',
        processedText: '加载成功',
        noMoreText: '没有更多了哟',
        failedText: '加载失败',
        messageText: '最后更新于 %T',
      );

  runApp(ScreenUtilInit(
      designSize: const Size(1080, 2400),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "cloudmusic",
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.rightToLeft,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: EasyLoading.init(),
        );
      }));
}
