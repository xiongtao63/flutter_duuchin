import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/preferred_tab_bar/PreferredTabBar.dart';
import 'package:flutter_duuchin/components/root_page_head/RootPageHead.dart';
import 'package:flutter_duuchin/view/sub_pages/recommend/MusicRecommendPage.dart';
import 'package:flutter_duuchin/view/sub_pages/singer/SingerPage.dart';
import 'package:flutter_duuchin/view/sub_pages/song/SongPage.dart';
import 'package:flutter_duuchin/view/sub_pages/song_sheet/SongSheetPage.dart';

// tabbar
const List<Widget> _tabs = [
  const Tab(text: '推荐'),
  const Tab(text: '歌曲'),
  const Tab(text: '歌手'),
  const Tab(text: '歌单'),
];

// tabbarView
final List<Widget> _tabsContent = [
  MusicRecommendPage(),
  SongPage(),
  SingerPage(),
  SongSheetPage(),
];

// 音乐
class MusicPage extends StatefulWidget {
  MusicPage({Key key}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  // tabController实例
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );
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
