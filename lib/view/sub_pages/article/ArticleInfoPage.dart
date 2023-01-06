import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/web_view_page/WebViewPage.dart';
import 'package:flutter_duuchin/config/DQColor.dart';
import 'package:flutter_duuchin/models/ArticleModel.dart';
import 'package:get/get.dart';

/// 文章详情
class ArticleInfoPage extends StatelessWidget {
  final ArticleListItem articleListItem;

  const ArticleInfoPage({Key key, this.articleListItem}) : super(key: key);

  _onAction() {
    Get.bottomSheet(
      SizedBox(
        height: 200,
        child: Center(child: Text('分享相关')),
      ),
      backgroundColor: DQColor.nav,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: _onAction,
          ),
        ],
        title: Text(
          articleListItem.title,
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: WebViewPage(
        initialUrl:
            'https://mp.duuchin.com/duuchin-article/index.html?id=${articleListItem.id}',
      ),
    );
  }
}
