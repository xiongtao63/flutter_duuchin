import 'package:flutter/material.dart';
import 'package:flutter_duuchin/config/DQColor.dart';
import 'package:flutter_duuchin/config/UserType.dart';
import 'package:flutter_duuchin/utils/util.dart';

// 头像角色昵称
class AvatarRoleName extends StatelessWidget {
  final String headIconUrl;
  final String username;
  final String userType;
  final bool showType;
  final double avatarSize;

  const AvatarRoleName({
    Key key,
    this.headIconUrl,
    this.userType,
    this.username,
    this.showType = true,
    this.avatarSize = 25.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [
      _avatar(),
      _username(),
    ];
    if (showType) {
      _list.insert(1, _role());
    }
    return Row(
      children: _list,
    );
  }

  // 头像
  Widget _avatar() {
    return Container(
      width: avatarSize,
      height: avatarSize,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: DQColor.page,
        borderRadius: BorderRadius.circular(avatarSize),
      ),
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/common/lazy-1.png',
          image: networkImageToDefault(headIconUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 角色
  Widget _role() {
    return Container(
      margin: EdgeInsets.only(left: 4),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        color: UserType.formColor(userType),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        UserType.formCn(userType),
        style: TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }

  // 昵称
  Widget _username() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(left: 4),
        child: Text(
          username ?? '读琴用户',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            color: DQColor.unactive,
          ),
        ),
      ),
    );
  }
}
