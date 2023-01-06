import 'package:flutter_duuchin/http/Http.dart';

// 歌单接口
class SongSheetService {
  static const String path = '/api/playlist/list';

  static Future getSongSheets({int page = 1}) async {
    final response = await Http.post(
      path,
      data: {'limit': 10, 'page': page},
    );
    Map<String, dynamic> result = response['page'];
    return result;
  }
}
