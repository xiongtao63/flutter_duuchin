import 'package:flutter/cupertino.dart';
import 'ModelInterface.dart';

// 列表模型
class SongSheetList {
  List<SongSheetListItem> list;
  SongSheetList(this.list);

  factory SongSheetList.fromJson(List<dynamic> list) {
    // 调用自身构造方法传值并返回
    return SongSheetList(
      list.map((listItem) => SongSheetListItem.fromJson(listItem)).toList(),
    );
  }
}

// 列表项模型
class SongSheetListItem implements RecommendInterface {
  final int id;
  final String coverPictureUrl;
  final String playlistName;
  final int songCount;
  final int playedCount;

  SongSheetListItem({
    @required this.id,
    @required this.coverPictureUrl,
    @required this.playlistName,
    @required this.songCount,
    @required this.playedCount,
  });

  factory SongSheetListItem.fromJson(dynamic listItem) {
    // 调用自身构造方法传值并返回
    return SongSheetListItem(
      id: listItem['id'],
      coverPictureUrl: listItem['coverPictureUrl'],
      playlistName: listItem['playlistName'],
      songCount: listItem['songCount'],
      playedCount: listItem['playedCount'],
    );
  }
}

// 详情模型
class SongSheetInfo {
  final int id;
  final String coverPictureUrl;
  final String playlistName;
  final int songCount;
  final int playedCount;

  SongSheetInfo({
    @required this.id,
    @required this.coverPictureUrl,
    @required this.playlistName,
    @required this.songCount,
    @required this.playedCount,
  });

  factory SongSheetInfo.fromJson(Map<String, dynamic> info) {
    return SongSheetInfo(
      id: info['id'],
      coverPictureUrl: info['coverPictureUrl'],
      playlistName: info['playlistName'],
      songCount: info['songCount'],
      playedCount: info['playedCount'],
    );
  }
}
