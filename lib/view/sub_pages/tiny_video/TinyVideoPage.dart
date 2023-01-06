import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/feedback/PageFeedBack.dart';
import 'package:flutter_duuchin/components/tiny_video_card/TinyVideoCard.dart';
import 'package:flutter_duuchin/models/TinyVideoModel.dart';
import 'package:flutter_duuchin/services/TinyVideoService.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'TinyVideoInfoPage.dart';

// 小视频
class TinyVideoPage extends StatefulWidget {
  TinyVideoPage({Key key}) : super(key: key);

  @override
  _TinyVideoPageState createState() => _TinyVideoPageState();
}

class _TinyVideoPageState extends State<TinyVideoPage>
    with AutomaticKeepAliveClientMixin {
  // 下拉刷新控制器
  EasyRefreshController _easyRefreshController;
  // 独立的滚动视图 防止tab切换时触发下拉刷新
  ScrollController _scrollController;
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

  // 刷新回调(null为不开启刷新)
  Future _onRefresh() async {
    if (error) {
      setState(() => error = false);
    }
    page = 1;
    await _getTinyVideos();
    // 恢复刷新状态 使onLoad再次可用
    _easyRefreshController.resetLoadState();
  }

  // 加载回调(null为不开启加载)
  Future _onLoad() async {
    if (hasMore) {
      await _getTinyVideos(replace: false);
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
        loading: loading,
        error: error,
        empty: _tinyVideoList.isEmpty,
        errorMsg: errorMsg,
        onErrorTap: () => _easyRefreshController.callRefresh(),
        onEmptyTap: () => _easyRefreshController.callRefresh(),
      ).build(),
      header: BezierCircleHeader(),
      footer: ClassicalFooter(),
      controller: _easyRefreshController,
      enableControlFinishRefresh: false,
      enableControlFinishLoad: true,
      onRefresh: _onRefresh,
      onLoad: _tinyVideoList.isEmpty ? null : _onLoad,
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 7,
          crossAxisSpacing: 1,
          childAspectRatio: 375 / 750,
        ),
        padding: const EdgeInsets.only(top: 7),
        itemCount: _tinyVideoList.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          final bool _isEven = index.isEven;
          final double _pr = _isEven ? 10 : 20;
          final double _pl = _isEven ? 20 : 10;

          return Container(
            padding: EdgeInsets.only(top: 20, left: _pl, right: _pr),
            color: Colors.white,
            child: TinyVideoCard(
              tinyVideoListItem: _tinyVideoList[index],
              onTap: (TinyVideoListItem tinyVideoListItem) {
                Get.to(TinyVideoInfoPage(infoId: tinyVideoListItem.id));
              },
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
