import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/avatar-role-name/AvatarRoleName.dart';
import 'package:flutter_duuchin/components/comment-like-read/CommentLikeRead.dart';
import 'package:flutter_duuchin/config/DQColor.dart';
import 'package:flutter_duuchin/models/SoundBookModel.dart';

// 听书每一个卡片
class SoundBookCard extends StatelessWidget {
  final SoundBookListItem soundBookListItem;

  const SoundBookCard({Key key, this.soundBookListItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _soundBookCover(),
          SizedBox(width: 10),
          _soundBookContent(),
        ],
      ),
    );
  }

  // 封面
  Widget _soundBookCover() {
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
              image: soundBookListItem.coverPictureUrl,
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

  Widget _soundBookContent() {
    return Expanded(
      child: SizedBox(
        height: 75,
        child: Stack(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 192,
              ),
              child: Text(
                soundBookListItem.bookName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: DQColor.active,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  print('专辑id：${soundBookListItem.soundBookPlaylistId}');
                },
                child: Container(
                  width: 60,
                  height: 28,
                  decoration: BoxDecoration(
                    color: DQColor.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/icons/sound_book_play_list.png',
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(width: 2),
                      Text('专辑', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 22,
              child: Text(
                '主播：' + soundBookListItem.autherName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
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
                      headIconUrl:
                          soundBookListItem.publishAppUserEntity['headIconUrl'],
                      username:
                          soundBookListItem.publishAppUserEntity['nickname'],
                      userType: soundBookListItem.publishAppUserEntity['type'],
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: CommentLikeRead(
                      commentCount: soundBookListItem.commentCount,
                      thumbUpCount: soundBookListItem.thumbUpCount,
                      readCount: soundBookListItem.readCount,
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
