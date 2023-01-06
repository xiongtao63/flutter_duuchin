import 'package:flutter/cupertino.dart';
import 'ModelInterface.dart';

// 列表模型
class VideoList {
  List<VideoListItem> list;
  VideoList(this.list);

  factory VideoList.fromJson(List<dynamic> list) {
    // 调用自身构造方法传值并返回
    return VideoList(
      list.map((listItem) => VideoListItem.fromJson(listItem)).toList(),
    );
  }
}

// 列表项模型
class VideoListItem implements RecommendInterface {
  final int id;
  final String coverPictureUrl;
  final String title;
  final String videoUrl;
  final Map<String, dynamic> publishAppUserEntity;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final int contentSeconds;

  VideoListItem({
    @required this.id,
    @required this.coverPictureUrl,
    @required this.title,
    @required this.videoUrl,
    @required this.publishAppUserEntity,
    @required this.commentCount,
    @required this.thumbUpCount,
    @required this.readCount,
    @required this.contentSeconds,
  });

  factory VideoListItem.fromJson(dynamic listItem) {
    // 调用自身构造方法传值并返回
    return VideoListItem(
      id: listItem['id'],
      coverPictureUrl: listItem['coverPictureUrl'],
      title: listItem['title'],
      videoUrl: listItem['videoUrl'],
      publishAppUserEntity: listItem['publishAppUserEntity'],
      commentCount: listItem['commentCount'],
      thumbUpCount: listItem['thumbUpCount'],
      readCount: listItem['readCount'],
      contentSeconds: listItem['contentSeconds'],
    );
  }
}

// 详情模型
class VideoInfo {
  final int id;
  final String coverPictureUrl;
  final String title;
  final Map publishAppUserEntity;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final int contentSeconds;

  VideoInfo({
    @required this.id,
    @required this.coverPictureUrl,
    @required this.title,
    @required this.publishAppUserEntity,
    @required this.commentCount,
    @required this.thumbUpCount,
    @required this.readCount,
    @required this.contentSeconds,
  });

  factory VideoInfo.fromJson(Map<String, dynamic> info) {
    return VideoInfo(
      id: info['id'],
      coverPictureUrl: info['coverPictureUrl'],
      title: info['title'],
      publishAppUserEntity: info['publishAppUserEntity'],
      commentCount: info['commentCount'],
      thumbUpCount: info['thumbUpCount'],
      readCount: info['readCount'],
      contentSeconds: info['contentSeconds'],
    );
  }
}
