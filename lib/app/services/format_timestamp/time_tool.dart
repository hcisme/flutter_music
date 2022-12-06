class Tool {
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
    // let min = parseInt(duration / 1000 / 60);
    // min = min < 10 ? '0' + min : min;
    // let sec = parseInt((duration / 1000) % 60);
    // sec = sec < 10 ? '0' + sec : sec;
    // const forTime = `${min}:${sec}`;
    // return forTime;
    final minute = duration / 1000 ~/ 60;
    var newMin = minute < 10 ? '0$minute' : minute;

    final second = (duration ~/ 1000) % 60;
    var newSec = second < 10 ? '0$second' : second;

    return '$newMin:$newSec';
  }
}
