import 'package:flutter/cupertino.dart';
import 'ModelInterface.dart';

// 列表模型
class TinyVideoList {
  List<TinyVideoListItem> list;
  TinyVideoList(this.list);

  factory TinyVideoList.fromJson(List<dynamic> list) {
    // 调用自身构造方法传值并返回
    return TinyVideoList(
      list.map((listItem) => TinyVideoListItem.fromJson(listItem)).toList(),
    );
  }
}

// 列表项模型
class TinyVideoListItem implements RecommendInterface {
  final int id;
  final String coverPictureUrl;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final Map<String, dynamic> publishAppUserEntity;
  final String videoUrl;
  final String intro;
  final bool thumbUp;

  TinyVideoListItem({
    @required this.id,
    @required this.coverPictureUrl,
    @required this.commentCount,
    @required this.thumbUpCount,
    @required this.readCount,
    @required this.publishAppUserEntity,
    @required this.videoUrl,
    @required this.intro,
    @required this.thumbUp,
  });

  factory TinyVideoListItem.fromJson(dynamic listItem) {
    // 调用自身构造方法传值并返回
    return TinyVideoListItem(
      id: listItem['id'],
      coverPictureUrl: listItem['coverPictureUrl'],
      commentCount: listItem['commentCount'],
      thumbUpCount: listItem['thumbUpCount'],
      readCount: listItem['readCount'],
      publishAppUserEntity: listItem['publishAppUserEntity'],
      videoUrl: listItem['videoUrl'],
      intro: listItem['intro'],
      thumbUp: listItem['thumbUp'],
    );
  }
}

// 详情模型
class TinyVideoInfo {
  final int id;
  final String coverPictureUrl;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final Map<String, dynamic> publishAppUserEntity;
  final String videoUrl;
  final String intro;
  final bool thumbUp;

  TinyVideoInfo({
    @required this.id,
    @required this.coverPictureUrl,
    @required this.commentCount,
    @required this.thumbUpCount,
    @required this.readCount,
    @required this.publishAppUserEntity,
    @required this.videoUrl,
    @required this.intro,
    @required this.thumbUp,
  });

  factory TinyVideoInfo.fromJson(Map<String, dynamic> info) {
    return TinyVideoInfo(
      id: info['id'],
      coverPictureUrl: info['coverPictureUrl'],
      commentCount: info['commentCount'],
      thumbUpCount: info['thumbUpCount'],
      readCount: info['readCount'],
      publishAppUserEntity: info['publishAppUserEntity'],
      videoUrl: info['videoUrl'],
      intro: info['intro'],
      thumbUp: info['thumbUp'],
    );
  }
}
