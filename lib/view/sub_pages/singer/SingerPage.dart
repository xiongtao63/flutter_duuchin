import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/feedback/PageFeedBack.dart';
import 'package:flutter_duuchin/components/singer_card/SingerCard.dart';
import 'package:flutter_duuchin/models/SingerModel.dart';
import 'package:flutter_duuchin/services/SingerService.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

// 歌手
class SingerPage extends StatefulWidget {
  SingerPage({Key key}) : super(key: key);

  @override
  _SingerPageState createState() => _SingerPageState();
}

class _SingerPageState extends State<SingerPage>
    with AutomaticKeepAliveClientMixin {
  // 下拉刷新控制器
  EasyRefreshController _easyRefreshController;
  // 独立的滚动视图 防止tab切换时触发下拉刷新
  ScrollController _scrollController;
  // 列表数组模型
  List<SingerListItem> _singerList = SingerList([]).list;
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
  Future _getSingers({bool replace = true}) async {
    try {
      Map<String, dynamic> result = await SingerService.getSingers(page: page);
      List<dynamic> singerList = result['list'];
      SingerList singerListModel = SingerList.fromJson(singerList);

      setState(() {
        hasMore = page * limit < result['totalCount'];
        page++;
        if (replace) {
          _singerList = singerListModel.list;
        } else {
          _singerList.addAll(singerListModel.list);
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
    await _getSingers();
    // 恢复刷新状态 使onLoad再次可用
    _easyRefreshController.resetLoadState();
  }

  // 加载回调(null为不开启加载)
  Future _onLoad() async {
    if (hasMore) {
      await _getSingers(replace: false);
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
        empty: _singerList.isEmpty,
        errorMsg: errorMsg,
        onErrorTap: () => _easyRefreshController.callRefresh(),
        onEmptyTap: () => _easyRefreshController.callRefresh(),
      ).build(),
      header: ClassicalHeader(),
      footer: ClassicalFooter(),
      controller: _easyRefreshController,
      enableControlFinishRefresh: false,
      enableControlFinishLoad: true,
      onRefresh: _onRefresh,
      onLoad: _singerList.isEmpty ? null : _onLoad,
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 7,
          crossAxisSpacing: 1,
          childAspectRatio: 375 / 498,
        ),
        padding: const EdgeInsets.only(top: 7),
        itemCount: _singerList.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          final bool _isEven = index.isEven;
          final double _pr = _isEven ? 10 : 20;
          final double _pl = _isEven ? 20 : 10;

          return Container(
            padding: EdgeInsets.only(top: 20, left: _pl, right: _pr),
            color: Colors.white,
            child: SingerCard(singerListItem: _singerList[index]),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
