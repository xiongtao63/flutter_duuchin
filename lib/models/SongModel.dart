import 'package:flutter/cupertino.dart';
import 'ModelInterface.dart';

// 列表模型
class SongList {
  List<SongListItem> list;
  SongList(this.list);

  factory SongList.fromJson(List<dynamic> list) {
    // 调用自身构造方法传值并返回
    return SongList(
      list.map((listItem) => SongListItem.fromJson(listItem)).toList(),
    );
  }
}

// 列表项模型
class SongListItem implements RecommendInterface {
  final int id;
  final String songCoverPictureUrl;
  final String songCnName;
  final String songEnName;
  final Map<String, dynamic> singerEntity;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;

  SongListItem({
    @required this.id,
    @required this.songCoverPictureUrl,
    @required this.songCnName,
    @required this.songEnName,
    @required this.singerEntity,
    @required this.commentCount,
    @required this.thumbUpCount,
    @required this.readCount,
  });

  factory SongListItem.fromJson(dynamic listItem) {
    // 调用自身构造方法传值并返回
    return SongListItem(
      id: listItem['id'],
      songCoverPictureUrl: listItem['songCoverPictureUrl'],
      songCnName: listItem['songCnName'],
      songEnName: listItem['songEnName'],
      singerEntity: listItem['singerEntity'],
      commentCount: listItem['commentCount'],
      thumbUpCount: listItem['thumbUpCount'],
      readCount: listItem['readCount'],
    );
  }
}

// 详情模型
class SongInfo {
  final int id;
  final String songCoverPictureUrl;
  final String songCnName;
  final String songEnName;
  final Map singerEntity;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;

  SongInfo({
    @required this.id,
    @required this.songCoverPictureUrl,
    @required this.songCnName,
    @required this.songEnName,
    @required this.singerEntity,
    @required this.commentCount,
    @required this.thumbUpCount,
    @required this.readCount,
  });

  factory SongInfo.fromJson(Map<String, dynamic> info) {
    return SongInfo(
      id: info['id'],
      songCoverPictureUrl: info['songCoverPictureUrl'],
      songCnName: info['songCnName'],
      songEnName: info['songEnName'],
      singerEntity: info['singerEntity'],
      commentCount: info['commentCount'],
      thumbUpCount: info['thumbUpCount'],
      readCount: info['readCount'],
    );
  }
}
