import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/avatar-role-name/AvatarRoleName.dart';
import 'package:flutter_duuchin/components/comment-like-read/CommentLikeRead.dart';
import 'package:flutter_duuchin/config/DQColor.dart';
import 'package:flutter_duuchin/models/ArticleModel.dart';
import 'package:flutter_duuchin/utils/util.dart';

// 文章每一个卡片
class ArticleCard extends StatefulWidget {
  final ArticleListItem articleListItem;
  final ValueChanged<ArticleListItem> onTap;

  ArticleCard({Key key, this.articleListItem, this.onTap}) : super(key: key);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

const double spaceSize = 10; // 盒子间距
const double bothSideSize = 20; // 盒子两边间距

class _ArticleCardState extends State<ArticleCard> {
  double boxSize; // 盒子大小

  @override
  Widget build(BuildContext context) {
    boxSize = MediaQuery.of(context).size.width - bothSideSize * 2;
    return InkWell(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap(widget.articleListItem);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(bothSideSize),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            SizedBox(height: bothSideSize),
            _getCoverByType(),
            SizedBox(height: bothSideSize),
            _bottom(),
          ],
        ),
      ),
    );
  }

  /// 基于图片长度获取图片类型
  /// coverType：1张->1 2张->2,3 3张->2,3,4,5,6,7 4张->8,2,3,4,5,6,7
  /// 1张->1种类型 2张->2种类型 3张->4种+2前种类型 4张->1种+前6种类型
  int _getTypeByLength() {
    int _coverLength = widget.articleListItem.coverUrlList.length;
    int _coverType;
    switch (_coverLength) {
      case 2:
        _coverType = getRandomRangeInt(2, 3);
        break;
      case 3:
        _coverType = getRandomRangeInt(2, 7);
        break;
      case 4:
        _coverType = getRandomRangeInt(2, 8);
        break;
      default:
        _coverType = 1;
    }
    return _coverType;
  }

  // 基于图片类型获取不同图片组合
  _getCoverByType() {
    int _coverType = _getTypeByLength();
    Widget _coverWidget;
    switch (_coverType) {
      case 2:
        _coverWidget = _cover2();
        break;
      case 3:
        _coverWidget = _cover3();
        break;
      case 4:
        _coverWidget = _cover4();
        break;
      case 5:
        _coverWidget = _cover5();
        break;
      case 6:
        _coverWidget = _cover6();
        break;
      case 7:
        _coverWidget = _cover7();
        break;
      case 8:
        _coverWidget = _cover8();
        break;
      default:
        _coverWidget = _cover1();
    }
    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: _coverWidget,
    );
  }

  /// 1张->1
  Widget _cover1() {
    return _cover(index: 0);
  }

  /// 2张->2,3
  Widget _cover2() {
    return Row(
      children: [
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 0),
        ),
        SizedBox(width: spaceSize),
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 1),
        ),
      ],
    );
  }

  /// 2张->2,3
  Widget _cover3() {
    return Column(
      children: [
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 0),
        ),
        SizedBox(height: spaceSize),
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 1),
        ),
      ],
    );
  }

  /// 3张->4,5,6,7
  Widget _cover4() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            SizedBox(width: spaceSize),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
          ],
        ),
        SizedBox(height: spaceSize),
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 2),
        ),
      ],
    );
  }

  /// 3张->4,5,6,7
  Widget _cover5() {
    return Column(
      children: [
        SizedBox(
          width: boxSize,
          height: boxSize / 2 - spaceSize / 2,
          child: _cover(index: 0),
        ),
        SizedBox(height: spaceSize),
        Row(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
            SizedBox(width: spaceSize),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 2),
            ),
          ],
        ),
      ],
    );
  }

  /// 3张->4,5,6,7
  Widget _cover6() {
    return Row(
      children: [
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 0),
        ),
        SizedBox(width: spaceSize),
        Column(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
            SizedBox(height: spaceSize),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 2),
            ),
          ],
        ),
      ],
    );
  }

  /// 3张->4,5,6,7
  Widget _cover7() {
    return Row(
      children: [
        Column(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            SizedBox(height: spaceSize),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
          ],
        ),
        SizedBox(width: spaceSize),
        SizedBox(
          width: boxSize / 2 - spaceSize / 2,
          height: boxSize,
          child: _cover(index: 2),
        ),
      ],
    );
  }

  /// 4张->8
  Widget _cover8() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 0),
            ),
            SizedBox(width: spaceSize),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 1),
            ),
          ],
        ),
        SizedBox(height: spaceSize),
        Row(
          children: [
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 2),
            ),
            SizedBox(width: spaceSize),
            SizedBox(
              width: boxSize / 2 - spaceSize / 2,
              height: boxSize / 2 - spaceSize / 2,
              child: _cover(index: 3),
            ),
          ],
        ),
      ],
    );
  }

  // 封面图
  Widget _cover({int index = 0}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/common/lazy-2.png',
        image: widget.articleListItem.coverUrlList[index],
        fit: BoxFit.cover,
      ),
    );
  }

  // 标题
  Widget _title() {
    return Text(
      widget.articleListItem.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16,
        color: DQColor.active,
      ),
    );
  }

  // 底部
  Widget _bottom() {
    return Row(
      children: [
        Expanded(
          child: AvatarRoleName(
            headIconUrl:
                widget.articleListItem.publishAppUserEntity['headIconUrl'],
            username: widget.articleListItem.publishAppUserEntity['nickname'],
            userType: widget.articleListItem.publishAppUserEntity['type'],
            avatarSize: 28,
          ),
        ),
        Expanded(
          child: CommentLikeRead(
            commentCount: widget.articleListItem.commentCount,
            thumbUpCount: widget.articleListItem.thumbUpCount,
            readCount: widget.articleListItem.readCount,
          ),
        ),
      ],
    );
  }
}
