import 'package:flutter_duuchin/http/Http.dart';

// 歌手接口
class SingerService {
  static const String path = '/api/singer/list';

  static Future getSingers({int page = 1}) async {
    final response = await Http.post(
      path,
      data: {'limit': 10, 'page': page, 'show': 1, 'showSet': 1},
    );
    Map<String, dynamic> result = response['page'];
    return result;
  }
}
