import 'package:flutter_duuchin/http/Http.dart';

// 听书接口
class SoundBookService {
  static const String path = '/api/soundbook/soundbook/list';

  static Future getSoundBooks({int page = 1}) async {
    final response = await Http.post(
      path,
      data: {'limit': 10, 'page': page, 'show': 1, 'showSet': 1},
    );
    Map<String, dynamic> result = response['page'];
    return result;
  }
}
