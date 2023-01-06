import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/feedback/PageFeedBack.dart';
import 'package:flutter_duuchin/components/song_sheet_card/SongSheetCard.dart';
import 'package:flutter_duuchin/models/SongSheetModel.dart';
import 'package:flutter_duuchin/services/SongSheetService.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

// 歌单
class SongSheetPage extends StatefulWidget {
  SongSheetPage({Key key}) : super(key: key);

  @override
  _SongSheetPageState createState() => _SongSheetPageState();
}

class _SongSheetPageState extends State<SongSheetPage>
    with AutomaticKeepAliveClientMixin {
  // 下拉刷新控制器
  EasyRefreshController _easyRefreshController;
  // 独立的滚动视图 防止tab切换时触发下拉刷新
  ScrollController _scrollController;
  // 列表数组模型
  List<SongSheetListItem> _songSheetList = SongSheetList([]).list;
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
  Future _getSongSheets({bool replace = true}) async {
    try {
      Map<String, dynamic> result =
          await SongSheetService.getSongSheets(page: page);
      List<dynamic> songSheetList = result['list'];
      SongSheetList songSheetListModel = SongSheetList.fromJson(songSheetList);

      setState(() {
        hasMore = page * limit < result['totalCount'];
        page++;
        if (replace) {
          _songSheetList = songSheetListModel.list;
        } else {
          _songSheetList.addAll(songSheetListModel.list);
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
    await _getSongSheets();
    // 刷新完成
    _easyRefreshController.finishRefresh();
  }

  // 加载回调(null为不开启加载)
  Future _onLoad() async {
    if (hasMore) {
      await _getSongSheets(replace: false);
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
        empty: _songSheetList.isEmpty,
        errorMsg: errorMsg,
        onErrorTap: () => _easyRefreshController.callRefresh(),
        onEmptyTap: () => _easyRefreshController.callRefresh(),
      ).build(),
      header: ClassicalHeader(),
      footer: ClassicalFooter(),
      controller: _easyRefreshController,
      taskIndependence: true,
      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,
      onRefresh: _onRefresh,
      onLoad: _songSheetList.isEmpty ? null : _onLoad,
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 7,
          crossAxisSpacing: 1,
          childAspectRatio: 375 / 498,
        ),
        padding: const EdgeInsets.only(top: 7),
        itemCount: _songSheetList.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          final bool _isEven = index.isEven;
          final double _pr = _isEven ? 10 : 20;
          final double _pl = _isEven ? 20 : 10;

          return Container(
            padding: EdgeInsets.only(top: 20, left: _pl, right: _pr),
            color: Colors.white,
            child: SongSheetCard(songSheetListItem: _songSheetList[index]),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
