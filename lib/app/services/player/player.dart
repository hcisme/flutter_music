import 'package:audioplayers/audioplayers.dart';
import 'package:cloudmusic/app/modules/tabs/controllers/tabs_controller.dart';
import 'package:get/get.dart';

class Audio {
  late AudioPlayer audioPlayer;

  static const url =
      'http://chcblogs.com/lib/images/%E6%98%A5%E5%A8%87%E4%B8%8E%E5%BF%97%E6%98%8E.mp3';

  // static _instance，_instance会在编译期被初始化，保证了只被创建一次
  static final Audio _instance = Audio._internal();

  //提供了一个工厂方法来获取该类的实例
  factory Audio() {
    return _instance;
  }

  // 通过私有方法_internal()隐藏了构造方法，防止被误创建
  Audio._internal() {
    audioPlayer = AudioPlayer();
  }

  /// 播放
  Future play(musicPath) async {
    musicPath = 'https${musicPath.split("http")[1]}';
    await audioPlayer.play(UrlSource(musicPath));

    // callback();
  }

  /// 继续播放
  Future continuePlay() async {
    await audioPlayer.resume();
  }

  /// 暂停
  Future pause() async {
    await audioPlayer.pause();
  }

  /// 释放
  Future release() async {
    await audioPlayer.release();
  }

  /// 拖动播放
  // Future seekPlay(Duration duration) async {
  //   int result = await audioPlayer.seek(duration);
  //   return result;
  // }

  /// 监听播放状态
  Future getStatus() async {
    audioPlayer.onPlayerStateChanged.listen((PlayerState s) => {
          if (s == PlayerState.completed ||
              s == PlayerState.paused ||
              s == PlayerState.stopped)
            {Get.find<TabsController>().flag.value = false}
          else if (s == PlayerState.playing)
            {Get.find<TabsController>().flag.value = true}
        });
  }
}
