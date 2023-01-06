import 'package:flutter/cupertino.dart';
import 'ModelInterface.dart';

// 列表模型
class SingerList {
  List<SingerListItem> list;
  SingerList(this.list);

  factory SingerList.fromJson(List<dynamic> list) {
    // 调用自身构造方法传值并返回
    return SingerList(
      list.map((listItem) => SingerListItem.fromJson(listItem)).toList(),
    );
  }
}

// 列表项模型
class SingerListItem implements RecommendInterface {
  final int id;
  final String headIconUrl;
  final String singerCnName;
  final String singerEnName;
  final int musicCount;
  final int musicPlayCount;

  SingerListItem({
    @required this.id,
    @required this.headIconUrl,
    @required this.singerCnName,
    @required this.singerEnName,
    @required this.musicCount,
    @required this.musicPlayCount,
  });

  factory SingerListItem.fromJson(dynamic listItem) {
    // 调用自身构造方法传值并返回
    return SingerListItem(
      id: listItem['id'],
      headIconUrl: listItem['headIconUrl'],
      singerCnName: listItem['singerCnName'],
      singerEnName: listItem['singerEnName'],
      musicCount: listItem['musicCount'],
      musicPlayCount: listItem['musicPlayCount'],
    );
  }
}

// 详情模型
class SingerInfo {
  final int id;
  final String headIconUrl;
  final String singerCnName;
  final String singerEnName;
  final int musicCount;
  final int musicPlayCount;

  SingerInfo({
    @required this.id,
    @required this.headIconUrl,
    @required this.singerCnName,
    @required this.singerEnName,
    @required this.musicCount,
    @required this.musicPlayCount,
  });

  factory SingerInfo.fromJson(Map<String, dynamic> info) {
    return SingerInfo(
      id: info['id'],
      headIconUrl: info['headIconUrl'],
      singerCnName: info['singerCnName'],
      singerEnName: info['singerEnName'],
      musicCount: info['musicCount'],
      musicPlayCount: info['musicPlayCount'],
    );
  }
}
