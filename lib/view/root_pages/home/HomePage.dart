import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/preferred_tab_bar/PreferredTabBar.dart';
import 'package:flutter_duuchin/components/root_page_head/RootPageHead.dart';
import 'package:flutter_duuchin/view/sub_pages/article/ArticlePage.dart';
import 'package:flutter_duuchin/view/sub_pages/recommend/HomeRecommendPage.dart';
import 'package:flutter_duuchin/view/sub_pages/singer/SingerPage.dart';
import 'package:flutter_duuchin/view/sub_pages/song/SongPage.dart';
import 'package:flutter_duuchin/view/sub_pages/sound_book/SoundBookPage.dart';
import 'package:flutter_duuchin/view/sub_pages/tiny_read/TinyReadPage.dart';
import 'package:flutter_duuchin/view/sub_pages/tiny_video/TinyVideoPage.dart';
import 'package:flutter_duuchin/view/sub_pages/topic/TopicPage.dart';
import 'package:flutter_duuchin/view/sub_pages/video/VideoPage.dart';

// tabbar
const List<Widget> _tabs = [
  const Tab(text: '微读'),
  const Tab(text: '推荐'),
  const Tab(text: '歌曲'),
  const Tab(text: '歌手'),
  const Tab(text: '小视频'),
  const Tab(text: '听书'),
  const Tab(text: '文章'),
  const Tab(text: '视频'),
  const Tab(text: '话题'),
];

// tabbarView
final List<Widget> _tabsContent = [
  TinyReadPage(),
  HomeRecommendPage(),
  SongPage(),
  SingerPage(),
  TinyVideoPage(),
  SoundBookPage(),
  ArticlePage(),
  VideoPage(),
  TopicPage(),
];

// 首页
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  // tabController实例
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 实例化TabController
    _tabController = TabController(
      initialIndex: 1,
      length: _tabs.length,
      vsync: this,
    );
    // 监听切换事件
    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: RootPageHead(),
        bottom: PreferredTabBar(
          tabController: _tabController,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabsContent,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
