import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';

class SmallTip extends StatelessWidget {
  final String playCount;

  const SmallTip({super.key, required this.playCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: ScreenAdapter.width(8), right: ScreenAdapter.width(12)),
      alignment: Alignment.center,
      height: ScreenAdapter.height(45),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.2)),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            Icons.play_arrow_outlined,
            size: ScreenAdapter.fs(40),
            color: Colors.white,
          ),
          Text(
            playCount,
            style:
                TextStyle(fontSize: ScreenAdapter.fs(32), color: Colors.white),
          )
        ],
      ),
    );
  }
}
