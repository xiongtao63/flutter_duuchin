import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/feedback/PageFeedBack.dart';
import 'package:flutter_duuchin/components/sound_book_card/SoundBookCard.dart';
import 'package:flutter_duuchin/models/SoundBookModel.dart';
import 'package:flutter_duuchin/services/SoundBookService.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

// 听书
class SoundBookPage extends StatefulWidget {
  SoundBookPage({Key key}) : super(key: key);

  @override
  _SoundBookPageState createState() => _SoundBookPageState();
}

class _SoundBookPageState extends State<SoundBookPage>
    with AutomaticKeepAliveClientMixin {
  // 下拉刷新控制器
  EasyRefreshController _easyRefreshController;
  // 独立的滚动视图 防止tab切换时触发下拉刷新
  ScrollController _scrollController;
  // 列表数组模型
  List<SoundBookListItem> _soundBookList = SoundBookList([]).list;
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
  Future _getSoundBooks({bool replace = true}) async {
    try {
      Map<String, dynamic> result =
          await SoundBookService.getSoundBooks(page: page);
      List<dynamic> soundBookList = result['list'];
      SoundBookList soundBookListModel = SoundBookList.fromJson(soundBookList);

      setState(() {
        hasMore = page * limit < result['totalCount'];
        page++;
        if (replace) {
          _soundBookList = soundBookListModel.list;
        } else {
          _soundBookList.addAll(soundBookListModel.list);
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
    await _getSoundBooks();
    // 恢复刷新状态 使onLoad再次可用
    _easyRefreshController.resetLoadState();
  }

  // 加载回调(null为不开启加载)
  Future _onLoad() async {
    if (hasMore) {
      await _getSoundBooks(replace: false);
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
        empty: _soundBookList.isEmpty,
        errorMsg: errorMsg,
        onErrorTap: () => _easyRefreshController.callRefresh(),
        onEmptyTap: () => _easyRefreshController.callRefresh(),
      ).build(),
      header: DeliveryHeader(),
      footer: ClassicalFooter(),
      controller: _easyRefreshController,
      enableControlFinishRefresh: false,
      enableControlFinishLoad: true,
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _soundBookList.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              SizedBox(height: 7),
              SoundBookCard(soundBookListItem: _soundBookList[index]),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
