import 'package:flutter/cupertino.dart';
import 'ModelInterface.dart';

// 列表模型
class SoundBookList {
  List<SoundBookListItem> list;
  SoundBookList(this.list);

  factory SoundBookList.fromJson(List<dynamic> list) {
    // 调用自身构造方法传值并返回
    return SoundBookList(
      list.map((listItem) => SoundBookListItem.fromJson(listItem)).toList(),
    );
  }
}

// 列表项模型
class SoundBookListItem implements RecommendInterface {
  final int id;
  final String coverPictureUrl;
  final String bookName;
  final String autherName;
  final Map<String, dynamic> publishAppUserEntity;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final int soundBookPlaylistId;

  SoundBookListItem({
    @required this.id,
    @required this.coverPictureUrl,
    @required this.bookName,
    @required this.autherName,
    @required this.publishAppUserEntity,
    @required this.commentCount,
    @required this.thumbUpCount,
    @required this.readCount,
    @required this.soundBookPlaylistId,
  });

  factory SoundBookListItem.fromJson(dynamic listItem) {
    // 调用自身构造方法传值并返回
    return SoundBookListItem(
      id: listItem['id'],
      coverPictureUrl: listItem['coverPictureUrl'],
      bookName: listItem['bookName'],
      autherName: listItem['autherName'],
      publishAppUserEntity: listItem['publishAppUserEntity'],
      commentCount: listItem['commentCount'],
      thumbUpCount: listItem['thumbUpCount'],
      readCount: listItem['readCount'],
      soundBookPlaylistId: listItem['soundBookPlaylistId'],
    );
  }
}

// 详情模型
class SoundBookInfo {
  final int id;
  final String coverPictureUrl;
  final String bookName;
  final String autherName;
  final Map publishAppUserEntity;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final int soundBookPlaylistId;

  SoundBookInfo({
    @required this.id,
    @required this.coverPictureUrl,
    @required this.bookName,
    @required this.autherName,
    @required this.publishAppUserEntity,
    @required this.commentCount,
    @required this.thumbUpCount,
    @required this.readCount,
    @required this.soundBookPlaylistId,
  });

  factory SoundBookInfo.fromJson(Map<String, dynamic> info) {
    return SoundBookInfo(
      id: info['id'],
      coverPictureUrl: info['coverPictureUrl'],
      bookName: info['bookName'],
      autherName: info['autherName'],
      publishAppUserEntity: info['publishAppUserEntity'],
      commentCount: info['commentCount'],
      thumbUpCount: info['thumbUpCount'],
      readCount: info['readCount'],
      soundBookPlaylistId: info['soundBookPlaylistId'],
    );
  }
}
