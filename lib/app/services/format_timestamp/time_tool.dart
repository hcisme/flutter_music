import 'package:flutter/material.dart';

class Tool {
  /// 关闭键盘
  static closeKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// 格式化播放次数
  static String formatPlayCount(num playCount) {
    if (playCount > 100000000) {
      return '${playCount ~/ 100000000}亿';
    } else if (playCount > 10000) {
      return '${playCount ~/ 10000}万';
    }
    return '$playCount';
  }

  //、 计算视频或者音乐播放时间
  static String formatDt(num duration) {
    final minute = duration / 1000 ~/ 60;
    var newMin = minute < 10 ? '0$minute' : minute;

    final second = (duration ~/ 1000) % 60;
    var newSec = second < 10 ? '0$second' : second;

    return '$newMin:$newSec';
  }
}
