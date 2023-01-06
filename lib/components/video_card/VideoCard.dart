import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/avatar-role-name/AvatarRoleName.dart';
import 'package:flutter_duuchin/components/comment-like-read/CommentLikeRead.dart';
import 'package:flutter_duuchin/config/DQColor.dart';
import 'package:flutter_duuchin/models/VideoModel.dart';
import 'package:flutter_duuchin/utils/util.dart';

// 视频每一个卡片
class VideoCard extends StatelessWidget {
  final VideoListItem videoListItem;
  final ValueChanged<VideoListItem> onTap;

  const VideoCard({Key key, this.videoListItem, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap(videoListItem);
        }
      },
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              videoListItem.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: DQColor.active,
              ),
            ),
            SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/common/lazy-2.png',
                      image: videoListItem.coverPictureUrl,
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
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        secondsToTime(videoListItem.contentSeconds),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: AvatarRoleName(
                    headIconUrl:
                        videoListItem.publishAppUserEntity['headIconUrl'],
                    username: videoListItem.publishAppUserEntity['nickname'],
                    userType: videoListItem.publishAppUserEntity['type'],
                    avatarSize: 28,
                  ),
                ),
                Expanded(
                  child: CommentLikeRead(
                    commentCount: videoListItem.commentCount,
                    thumbUpCount: videoListItem.thumbUpCount,
                    readCount: videoListItem.readCount,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
