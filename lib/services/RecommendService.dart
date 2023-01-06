import 'package:flutter_duuchin/http/Http.dart';

// 推荐接口
class RecommendService {
  static const String path = '/api/union/gatherrecommend/list';

  static Future getRecommends({int page = 1}) async {
    final response = await Http.post(
      path,
      data: {'limit': 20, 'page': page},
    );
    Map<String, dynamic> result = response['page'];
    return result;
  }
}
