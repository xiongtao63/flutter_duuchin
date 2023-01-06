import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/article_card/ArticleCard.dart';
import 'package:flutter_duuchin/components/feedback/PageFeedBack.dart';
import 'package:flutter_duuchin/components/song_card/SongCard.dart';
import 'package:flutter_duuchin/components/sound_book_card/SoundBookCard.dart';
import 'package:flutter_duuchin/components/video_card/VideoCard.dart';
import 'package:flutter_duuchin/components/yurt_header/YurtHeader.dart';
import 'package:flutter_duuchin/models/ArticleModel.dart';
import 'package:flutter_duuchin/models/ModelInterface.dart';
import 'package:flutter_duuchin/models/SongModel.dart';
import 'package:flutter_duuchin/models/SoundBookModel.dart';
import 'package:flutter_duuchin/models/VideoModel.dart';
import 'package:flutter_duuchin/services/RecommendService.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

// 推荐
class HomeRecommendPage extends StatefulWidget {
  HomeRecommendPage({Key key}) : super(key: key);

  @override
  _HomeRecommendPageState createState() => _HomeRecommendPageState();
}

class _HomeRecommendPageState extends State<HomeRecommendPage>
    with AutomaticKeepAliveClientMixin {
  // 下拉刷新控制器
  EasyRefreshController _easyRefreshController;
  // 独立的滚动视图 防止tab切换时触发下拉刷新
  ScrollController _scrollController;
  // 不同类型的推荐列表
  // RecommendInterface定义标准 返回的模型必须继承自它
  List<RecommendInterface> _recommendList = SongList([]).list;
  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool loading = true;
  bool error = false;
  String errorMsg;

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _easyRefreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // 获取数据
  Future _getRecommends({bool replace = true}) async {
    try {
      Map<String, dynamic> result =
          await RecommendService.getRecommends(page: page);
      List<dynamic> list = result['list'];
      // 基于不同数据类型 返回不同的数据模型
      List<RecommendInterface> recommendList = list.map((item) {
        if (item['songEntity'] != null) {
          return SongListItem.fromJson(item['songEntity']);
        } else if (item['soundBookEntity'] != null) {
          return SoundBookListItem.fromJson(item['soundBookEntity']);
        } else if (item['videoEntity'] != null) {
          return VideoListItem.fromJson(item['videoEntity']);
        } else if (item['articleEntity'] != null) {
          return ArticleListItem.fromJson(item['articleEntity']);
        }
      }).toList();

      setState(() {
        hasMore = page * limit < result['totalCount'];
        page++;
        if (replace) {
          _recommendList = recommendList;
        } else {
          _recommendList.addAll(recommendList);
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

  // 刷新回调(null为不开启刷新)
  Future _onRefresh() async {
    if (error) {
      setState(() => error = false);
    }
    page = 1;
    await _getRecommends();
    // 恢复刷新状态 使onLoad再次可用
    _easyRefreshController.resetLoadState();
  }

  // 加载回调(null为不开启加载)
  Future _onLoad() async {
    if (hasMore) {
      await _getRecommends(replace: false);
    }
    // 结束加载
    _easyRefreshController.finishLoad(noMore: !hasMore);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      firstRefresh: true,
      firstRefreshWidget: PageFeedBack(firstRefresh: true).build(),
      emptyWidget: PageFeedBack(
        loading: false,
        error: error,
        empty: _recommendList.isEmpty,
        errorMsg: errorMsg,
        onErrorTap: () => _easyRefreshController.callRefresh(),
        onEmptyTap: () => _easyRefreshController.callRefresh(),
      ).build(),
      header: YurtHeader(),
      footer: ClassicalFooter(),
      controller: _easyRefreshController,
      enableControlFinishRefresh: false,
      enableControlFinishLoad: true,
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _recommendList.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          final RecommendInterface widgetModel = _recommendList[index];
          return _getWidgetByRecommendInterface(widgetModel);
        },
      ),
    );
  }

  // 基于不同数据模型 返回不同的组件
  Widget _getWidgetByRecommendInterface(RecommendInterface widgetModel) {
    if (widgetModel is SongListItem) {
      return _columnSlot(SongCard(songListItem: widgetModel));
    } else if (widgetModel is SoundBookListItem) {
      return _columnSlot(SoundBookCard(soundBookListItem: widgetModel));
    } else if (widgetModel is VideoListItem) {
      return _columnSlot(VideoCard(videoListItem: widgetModel));
    } else if (widgetModel is ArticleListItem) {
      return _columnSlot(ArticleCard(articleListItem: widgetModel));
    } else {
      return SizedBox.shrink();
    }
  }

  // column插槽
  Widget _columnSlot(Widget widget) {
    return Column(
      children: [
        SizedBox(height: 7),
        widget,
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
