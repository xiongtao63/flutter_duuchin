import 'package:flutter_duuchin/http/Http.dart';

// 文章接口
class ArticleService {
  static const String path = '/api/article/list';

  static Future getArticles({int page = 1}) async {
    final response = await Http.post(
      path,
      data: {'limit': 10, 'page': page, 'show': 1, 'showSet': 1},
    );
    Map<String, dynamic> result = response['page'];
    return result;
  }
}
