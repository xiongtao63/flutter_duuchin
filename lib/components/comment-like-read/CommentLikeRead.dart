import 'package:flutter/material.dart';
import 'package:flutter_duuchin/config/DQColor.dart';
import 'package:flutter_duuchin/utils/util.dart';

// 评论点赞查看
class CommentLikeRead extends StatelessWidget {
  final int commentCount;
  final int thumbUpCount;
  final int readCount;

  const CommentLikeRead({
    Key key,
    this.commentCount,
    this.readCount,
    this.thumbUpCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _iconItem('assets/images/icons/comment.png', commentCount),
        _iconItem('assets/images/icons/like.png', thumbUpCount),
        _iconItem('assets/images/icons/read.png', readCount),
      ],
    );
  }

  Widget _iconItem(String icon, int count) {
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
              formatCharCount(count),
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
