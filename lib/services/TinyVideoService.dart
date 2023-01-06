import 'package:flutter_duuchin/http/Http.dart';

// 小视频接口
class TinyVideoService {
  static const String rootPath = '/api/tinyVideo';
  static const String listPath = '$rootPath/list';
  static const String infoPath = '$rootPath/info';

  static Future getTinyVideos({int page = 1}) async {
    final response = await Http.post(
      listPath,
      data: {'limit': 10, 'page': page + 2, 'show': 1, 'showSet': 1},
    );
    Map<String, dynamic> result = response['page'];
    return result;
  }

  static Future getTinyVideoInfo(int id) async {
    final response = await Http.get('$infoPath/$id');
    Map<String, dynamic> info = response['tinyVideo'];
    return info;
  }
}
