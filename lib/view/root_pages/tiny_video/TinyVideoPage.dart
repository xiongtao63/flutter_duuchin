import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/feedback/PageFeedBack.dart';
import 'package:flutter_duuchin/components/tiny_video_player/TinyVideoPlayer.dart';
import 'package:flutter_duuchin/models/TinyVideoModel.dart';
import 'package:flutter_duuchin/services/TinyVideoService.dart';

// 小视频
class TinyVideoPage extends StatefulWidget {
  TinyVideoPage({Key key}) : super(key: key);

  @override
  _TinyVideoPageState createState() => _TinyVideoPageState();
}

class _TinyVideoPageState extends State<TinyVideoPage>
    with AutomaticKeepAliveClientMixin {
  // 创建滚动页面
  PageController _pageController;
  // 列表数组模型
  List<TinyVideoListItem> _tinyVideoList = TinyVideoList([]).list;
  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool loading = true;
  bool error = false;
  String errorMsg;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(keepPage: false);
    _getTinyVideos();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // 获取数据
  Future _getTinyVideos({bool replace = true}) async {
    try {
      Map<String, dynamic> result =
          await TinyVideoService.getTinyVideos(page: page);
      List<dynamic> tinyVideoList = result['list'];
      TinyVideoList tinyVideoListModel = TinyVideoList.fromJson(tinyVideoList);

      setState(() {
        hasMore = page * limit < result['totalCount'];
        page++;
        if (replace) {
          _tinyVideoList = tinyVideoListModel.list;
        } else {
          _tinyVideoList.addAll(tinyVideoListModel.list);
        }
      });
    } catch (e) {
      setState(() {
        error = true;
        errorMsg = e.toString();
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  // 监听页面切换
  void _onPageChanged(int index) {
    // 最后一个页面
    if (_tinyVideoList.length - 1 == index && hasMore) {
      _getTinyVideos(replace: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget _body;
    if (loading) {
      _body = PageFeedBack(firstRefresh: true).build();
    } else if (error) {
      _body = PageFeedBack(
        loading: false,
        error: true,
        errorMsg: errorMsg,
        onErrorTap: () {
          setState(() {
            loading = true;
            error = false;
          });
          _getTinyVideos();
        },
      ).build();
    } else {
      _body = PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        scrollDirection: Axis.vertical,
        itemCount: _tinyVideoList.length,
        itemBuilder: (BuildContext context, int index) {
          return TinyVideoPlayer(tinyVideoListItem: _tinyVideoList[index]);
        },
      );
    }
    return Scaffold(
      body: _body,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
