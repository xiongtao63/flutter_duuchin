import 'package:flutter/material.dart';
import 'package:flutter_duuchin/config/DQColor.dart';
import 'package:flutter_duuchin/models/SingerModel.dart';
import 'package:flutter_duuchin/utils/util.dart';

// 歌手每个卡片
class SingerCard extends StatelessWidget {
  final SingerListItem singerListItem;

  const SingerCard({Key key, this.singerListItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/common/lazy-1.png',
              image: singerListItem.headIconUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            singerListItem.singerCnName + ' ' + singerListItem.singerEnName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: DQColor.active,
            ),
          ),
        ),
        Row(
          children: [
            _iconItem(
              'assets/images/icons/read.png',
              '歌曲',
              singerListItem.musicCount,
            ),
            _iconItem(
              'assets/images/icons/read.png',
              '播放',
              singerListItem.musicPlayCount,
            ),
          ],
        ),
      ],
    );
  }

  Widget _iconItem(String icon, String label, int count) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 18,
            height: 18,
          ),
          SizedBox(width: 2),
          Expanded(
            flex: 1,
            child: Text(
              label + ':' + formatCharCount(count),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: DQColor.un3active,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
