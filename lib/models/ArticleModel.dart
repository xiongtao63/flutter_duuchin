import 'package:flutter/cupertino.dart';
import 'ModelInterface.dart';

// 列表模型
class ArticleList {
  List<ArticleListItem> list;
  ArticleList(this.list);

  factory ArticleList.fromJson(List<dynamic> list) {
    // 调用自身构造方法传值并返回
    return ArticleList(
      list.map((listItem) => ArticleListItem.fromJson(listItem)).toList(),
    );
  }
}

// 列表项模型
class ArticleListItem implements RecommendInterface {
  final int id;
  final List<dynamic> coverUrlList;
  final String title;
  final Map<String, dynamic> publishAppUserEntity;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;

  ArticleListItem({
    @required this.id,
    @required this.coverUrlList,
    @required this.title,
    @required this.publishAppUserEntity,
    @required this.commentCount,
    @required this.thumbUpCount,
    @required this.readCount,
  });

  factory ArticleListItem.fromJson(dynamic listItem) {
    // 调用自身构造方法传值并返回
    return ArticleListItem(
      id: listItem['id'],
      coverUrlList: listItem['coverUrlList'],
      title: listItem['title'],
      publishAppUserEntity: listItem['publishAppUserEntity'],
      commentCount: listItem['commentCount'],
      thumbUpCount: listItem['thumbUpCount'],
      readCount: listItem['readCount'],
    );
  }
}

// 详情模型
class ArticleInfo {
  final int id;
  final List<dynamic> coverUrlList;
  final String title;
  final Map<String, dynamic> publishAppUserEntity;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;

  ArticleInfo({
    @required this.id,
    @required this.coverUrlList,
    @required this.title,
    @required this.publishAppUserEntity,
    @required this.commentCount,
    @required this.thumbUpCount,
    @required this.readCount,
  });

  factory ArticleInfo.fromJson(Map<String, dynamic> info) {
    return ArticleInfo(
      id: info['id'],
      coverUrlList: info['coverUrlList'],
      title: info['title'],
      publishAppUserEntity: info['publishAppUserEntity'],
      commentCount: info['commentCount'],
      thumbUpCount: info['thumbUpCount'],
      readCount: info['readCount'],
    );
  }
}
