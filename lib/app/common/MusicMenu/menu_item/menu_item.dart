import 'package:cloudmusic/app/services/screenAdapter/screenAdapter.dart';
import 'package:flutter/material.dart';

class MusicMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;

  const MusicMenuItem(
      {super.key, required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.only(
            top: ScreenAdapter.width(24),
            right: ScreenAdapter.width(24),
            bottom: ScreenAdapter.width(24)),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black54,
            ),
            SizedBox(
              width: ScreenAdapter.width(32),
            ),
            Expanded(
                child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.w300),
            ))
          ],
        ),
      ),
    );
  }
}
