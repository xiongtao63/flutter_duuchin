import 'package:flutter/material.dart';
import 'package:flutter_duuchin/config/DQColor.dart';
import 'package:flutter_duuchin/utils/util.dart';

class ActionsToolbar extends StatefulWidget {
  final int commentCount;
  final int thumbUpCount;
  final int shareCount;
  final bool thumbUp;
  final String userAvatar;
  final AnimationController animationController;

  ActionsToolbar({
    Key key,
    this.commentCount,
    this.thumbUpCount,
    this.shareCount,
    this.thumbUp,
    this.userAvatar,
    this.animationController,
  }) : super(key: key);

  @override
  _ActionsToolbarState createState() => _ActionsToolbarState();
}

class _ActionsToolbarState extends State<ActionsToolbar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _avatar(),
        SizedBox(height: toRpx(size: 38)),
        _iconText(
          icon: 'assets/images/icons/heart.png',
          count: widget.thumbUpCount,
          thumbUp: widget.thumbUp,
        ),
        SizedBox(height: toRpx(size: 38)),
        _iconText(
          icon: 'assets/images/icons/comment2.png',
          count: widget.commentCount,
        ),
        SizedBox(height: toRpx(size: 38)),
        _iconText(
          icon: 'assets/images/icons/share.png',
          count: widget.shareCount,
        ),
        SizedBox(height: toRpx(size: 40)),
        _rotate(),
      ],
    );
  }

  // 头像
  Widget _avatar() {
    return Container(
      width: toRpx(size: 90),
      height: toRpx(size: 106),
      child: Stack(
        children: [
          Container(
            width: toRpx(size: 90),
            height: toRpx(size: 90),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(toRpx(size: 90)),
            ),
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/common/lazy-1.png',
                image: networkImageToDefault(widget.userAvatar),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: toRpx(size: 38),
              height: toRpx(size: 38),
              decoration: BoxDecoration(
                color: DQColor.danger,
                borderRadius: BorderRadius.circular(toRpx(size: 38)),
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 点赞评论。。。
  Widget _iconText({String icon, int count, bool thumbUp = false}) {
    return Column(
      children: [
        Image.asset(
          icon,
          width: toRpx(size: 70),
          height: toRpx(size: 70),
          color: thumbUp ? DQColor.danger : Colors.white,
        ),
        SizedBox(height: toRpx(size: 4)),
        Text(
          formatCharCount(count),
          style: TextStyle(
            color: Colors.white,
            fontSize: toRpx(size: 26),
          ),
        ),
      ],
    );
  }

  // 圆盘
  Widget _rotate() {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(widget.animationController),
      child: Container(
        width: toRpx(size: 90),
        height: toRpx(size: 90),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/common/bgm.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipOval(
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/common/lazy-1.png',
            image: networkImageToDefault(widget.userAvatar),
            width: toRpx(size: 50),
            height: toRpx(size: 50),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
