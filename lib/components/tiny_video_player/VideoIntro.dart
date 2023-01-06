import 'package:flutter/material.dart';
import 'package:flutter_duuchin/utils/util.dart';
import 'package:marquee/marquee.dart';

class VideoIntro extends StatelessWidget {
  final String nickname;
  final String intro;
  const VideoIntro({Key key, this.nickname, this.intro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '@$nickname',
          style: TextStyle(
            color: Colors.white,
            fontSize: toRpx(size: 30),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: toRpx(size: 5)),
        Text(
          intro,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: toRpx(size: 26),
          ),
        ),
        SizedBox(height: toRpx(size: 5)),
        Row(
          children: [
            Image.asset(
              'assets/images/common/music.png',
              width: toRpx(size: 36),
              height: toRpx(size: 36),
              color: Colors.white,
            ),
            SizedBox(width: toRpx(size: 5)),
            SizedBox(
              width: toRpx(size: 370),
              height: toRpx(size: 36),
              child: Marquee(
                text: '@$nickname创作的原声',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: toRpx(size: 26),
                ),
                scrollAxis: Axis.horizontal,
                blankSpace: toRpx(size: 30),
                velocity: 40.0,
                fadingEdgeStartFraction: 0.1,
                fadingEdgeEndFraction: 0.1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
