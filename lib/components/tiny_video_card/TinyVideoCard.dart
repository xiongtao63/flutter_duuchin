import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/avatar-role-name/AvatarRoleName.dart';
import 'package:flutter_duuchin/components/comment-like-read/CommentLikeRead.dart';
import 'package:flutter_duuchin/models/TinyVideoModel.dart';
import 'package:flutter_duuchin/utils/util.dart';

// 小视频每个卡片
class TinyVideoCard extends StatelessWidget {
  final TinyVideoListItem tinyVideoListItem;
  final ValueChanged<TinyVideoListItem> onTap;

  const TinyVideoCard({
    Key key,
    this.tinyVideoListItem,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap(tinyVideoListItem);
        }
      },
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 312 / 560,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/common/lazy-3.png',
                    image: networkImageToDefault(
                        tinyVideoListItem.coverPictureUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/icons/play_plus.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: AvatarRoleName(
              headIconUrl: tinyVideoListItem.publishAppUserEntity != null
                  ? tinyVideoListItem.publishAppUserEntity['headIconUrl']
                  : null,
              username: tinyVideoListItem.publishAppUserEntity != null
                  ? tinyVideoListItem.publishAppUserEntity['nickname']
                  : null,
              userType: tinyVideoListItem.publishAppUserEntity != null
                  ? tinyVideoListItem.publishAppUserEntity['type']
                  : null,
            ),
          ),
          CommentLikeRead(
            commentCount: tinyVideoListItem.commentCount,
            thumbUpCount: tinyVideoListItem.thumbUpCount,
            readCount: tinyVideoListItem.readCount,
          ),
        ],
      ),
    );
  }
}
