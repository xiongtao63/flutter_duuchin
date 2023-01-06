import 'package:flutter_duuchin/http/Http.dart';

// 歌曲接口
class SongService {
  static const String path = '/api/song/list';

  static Future getSongs({int page = 1}) async {
    final response = await Http.post(
      path,
      data: {'limit': 10, 'page': page, 'show': 1, 'showSet': 1},
    );
    Map<String, dynamic> result = response['page'];
    return result;
  }
}
