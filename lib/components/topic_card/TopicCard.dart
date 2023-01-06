import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/avatar-role-name/AvatarRoleName.dart';
import 'package:flutter_duuchin/components/comment-like-read/CommentLikeRead.dart';
import 'package:flutter_duuchin/config/DQColor.dart';
import 'package:flutter_duuchin/models/TopicModel.dart';

const Map<int, String> topicTypeText = {
  1: '图文',
  2: '小视频',
};

// 话题每一个卡片
class TopicCard extends StatelessWidget {
  final TopicListItem topicListItem;

  const TopicCard({Key key, this.topicListItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          SizedBox(height: 20),
          _cover(),
          SizedBox(height: 20),
          _bottom(),
        ],
      ),
    );
  }

  Widget _title() {
    return Text.rich(
      TextSpan(
        text: topicTypeText[topicListItem.topicType] + '话题活动 ',
        style: TextStyle(
          color: DQColor.danger,
        ),
        children: [
          TextSpan(
            text: topicListItem.title,
            style: TextStyle(
              color: DQColor.active,
            ),
          ),
        ],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _cover() {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/common/lazy-1.png',
          image: topicListItem.coverPicUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _bottom() {
    return Row(
      children: [
        Expanded(
          child: AvatarRoleName(
            headIconUrl: topicListItem.publishUserEntity['headIconUrl'],
            username: topicListItem.publishUserEntity['nickname'],
            userType: topicListItem.publishUserEntity['type'],
            avatarSize: 28,
          ),
        ),
        Expanded(
          child: CommentLikeRead(
            commentCount: topicListItem.commentCount,
            thumbUpCount: topicListItem.participateUserCount,
            readCount: topicListItem.readCount,
          ),
        ),
      ],
    );
  }
}
