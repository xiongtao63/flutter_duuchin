import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/avatar-role-name/AvatarRoleName.dart';
import 'package:flutter_duuchin/components/comment-like-read/CommentLikeRead.dart';
import 'package:flutter_duuchin/config/DQColor.dart';
import 'package:flutter_duuchin/models/SongModel.dart';

// 歌曲每一个卡片
class SongCard extends StatelessWidget {
  final SongListItem songListItem;

  const SongCard({Key key, this.songListItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _songCover(),
          SizedBox(width: 10),
          _songContent(),
        ],
      ),
    );
  }

  // 封面
  Widget _songCover() {
    return Container(
      width: 75,
      height: 75,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/common/lazy-1.png',
              image: songListItem.songCoverPictureUrl,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/icons/play_plus.png',
              width: 22,
              height: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _songContent() {
    return Expanded(
      child: SizedBox(
        height: 75,
        child: Stack(
          children: [
            Text(
              songListItem.songCnName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: DQColor.active,
              ),
            ),
            Positioned(
              top: 22,
              child: Text(
                songListItem.songEnName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: DQColor.unactive,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: AvatarRoleName(
                      headIconUrl: songListItem.singerEntity['headIconUrl'],
                      username: songListItem.singerEntity['singerCnName'],
                      showType: false,
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: CommentLikeRead(
                      commentCount: songListItem.commentCount,
                      thumbUpCount: songListItem.thumbUpCount,
                      readCount: songListItem.readCount,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
