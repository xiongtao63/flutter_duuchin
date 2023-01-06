import 'package:flutter_duuchin/http/Http.dart';

// 话题接口
class TopicService {
  static const String path = '/api/topic/topic/list';

  static Future getTopics({int page = 1}) async {
    final response = await Http.post(
      path,
      data: {'limit': 10, 'page': page},
    );
    Map<String, dynamic> result = response['page'];
    return result;
  }
}
