import 'package:flutter_duuchin/http/Http.dart';

// 视频接口
class VideoService {
  static const String path = '/api/video/list';

  static Future getVideos({int page = 1}) async {
    final response = await Http.post(
      path,
      data: {'limit': 10, 'page': page, 'show': 1, 'showSet': 1},
    );
    Map<String, dynamic> result = response['page'];
    return result;
  }
}
