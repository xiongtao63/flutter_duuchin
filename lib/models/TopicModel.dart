import 'package:flutter/cupertino.dart';
import 'ModelInterface.dart';

// 列表模型
class TopicList {
  List<TopicListItem> list;
  TopicList(this.list);

  factory TopicList.fromJson(List<dynamic> list) {
    // 调用自身构造方法传值并返回
    return TopicList(
      list.map((listItem) => TopicListItem.fromJson(listItem)).toList(),
    );
  }
}

// 列表项模型
class TopicListItem implements RecommendInterface {
  final int id;
  final String coverPicUrl;
  final String title;
  final Map<String, dynamic> publishUserEntity;
  final int commentCount;
  final int readCount;
  final int participateUserCount;
  final int topicType;

  TopicListItem({
    @required this.id,
    @required this.coverPicUrl,
    @required this.title,
    @required this.publishUserEntity,
    @required this.commentCount,
    @required this.readCount,
    @required this.participateUserCount,
    @required this.topicType,
  });

  factory TopicListItem.fromJson(dynamic listItem) {
    // 调用自身构造方法传值并返回
    return TopicListItem(
      id: listItem['id'],
      coverPicUrl: listItem['coverPicUrl'],
      title: listItem['title'],
      publishUserEntity: listItem['publishUserEntity'],
      commentCount: listItem['commentCount'],
      readCount: listItem['readCount'],
      participateUserCount: listItem['participateUserCount'],
      topicType: listItem['topicType'],
    );
  }
}

// 详情模型
class TopicInfo {
  final int id;
  final String coverPicUrl;
  final String title;
  final Map<String, dynamic> publishUserEntity;
  final int commentCount;
  final int readCount;
  final int participateUserCount;
  final int topicType;

  TopicInfo({
    @required this.id,
    @required this.coverPicUrl,
    @required this.title,
    @required this.publishUserEntity,
    @required this.commentCount,
    @required this.readCount,
    @required this.participateUserCount,
    @required this.topicType,
  });

  factory TopicInfo.fromJson(Map<String, dynamic> info) {
    return TopicInfo(
      id: info['id'],
      coverPicUrl: info['coverPicUrl'],
      title: info['title'],
      publishUserEntity: info['publishUserEntity'],
      commentCount: info['commentCount'],
      readCount: info['readCount'],
      participateUserCount: info['participateUserCount'],
      topicType: info['topicType'],
    );
  }
}
