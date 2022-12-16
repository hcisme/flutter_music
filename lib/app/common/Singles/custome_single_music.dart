import 'dart:ffi';

import 'package:cloudmusic/app/services/iconfont/iconfont.dart';
import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';

/// 自定义音乐列表
class CustomeSingleMusic extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final double? height;
  final String subTitle;
  final String artist;
  final bool level;
  final bool isVip;
  final bool originCoverType;
  final String? thirdTitle;
  final Function()? onTap;
  final Function()? onTapMore;
  final Function()? onTapToPlayMmv;
  final bool isMv;
  final EdgeInsetsGeometry? margin;

  const CustomeSingleMusic({
    super.key,
    required this.title,
    required this.subTitle,
    required this.artist,
    required this.level,
    required this.isVip,
    required this.originCoverType,
    this.thirdTitle = '',
    this.onTap,
    this.onTapMore,
    this.titleColor = Colors.black87,
    this.height = 60,
    this.margin,
    this.onTapToPlayMmv,
    required this.isMv,
  });

  final double _fs = 36;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(ScreenAdapter.width(8)),
        child: Container(
          width: double.infinity,
          height: height,
          padding: EdgeInsets.only(left: ScreenAdapter.width(24)),
          margin: margin,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 标题
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: ScreenAdapter.fs(40),
                                color: titleColor),
                          ))
                        ],
                      ),
                      // 二级
                      Row(
                        children: [
                          originCoverType
                              ? Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenAdapter.width(10),
                                      vertical: ScreenAdapter.width(4)),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenAdapter.width(10)))),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Text(
                                    '原唱',
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.fs(18),
                                        color: Colors.white,
                                        textBaseline: TextBaseline.alphabetic),
                                  ))
                              : const Text(''),
                          level
                              ? Icon(
                                  IconFont.sq,
                                  color: Colors.red,
                                  size: ScreenAdapter.fs(60),
                                )
                              : const Text(''),
                          isVip
                              ? Icon(
                                  IconFont.vip,
                                  color: Colors.red,
                                  size: ScreenAdapter.fs(60),
                                )
                              : const Text(''),
                          Expanded(
                            child: Text(
                              artist,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fs(_fs),
                                  color: Colors.black38),
                            ),
                          ),
                        ],
                      ),
                      // 三级
                      subTitle.isEmpty
                          ? const SizedBox(
                              height: 0,
                            )
                          : Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    subTitle,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: ScreenAdapter.fs(_fs),
                                      color: Colors.black38,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  )),
              isMv
                  ? IconButton(
                      onPressed: onTapToPlayMmv ?? () {},
                      padding: const EdgeInsets.all(0),
                      icon: Icon(
                        IconFont.mvs,
                        color: Colors.black38,
                        size: ScreenAdapter.fs(56),
                      ))
                  : const Text(''),
              IconButton(
                  onPressed: onTapMore ?? () {},
                  padding: const EdgeInsets.all(0),
                  icon: Icon(
                    Icons.more_vert_outlined,
                    color: Colors.black38,
                    size: ScreenAdapter.fs(56),
                  ))
            ],
          ),
        ));
  }
}
