import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duuchin/config/DQColor.dart';
import 'package:flutter_duuchin/view/root_pages/create_media/CreateMedia.dart';
import 'package:flutter_duuchin/view/root_pages/home/HomePage.dart';
import 'package:flutter_duuchin/view/root_pages/music/MusicPage.dart';
import 'package:flutter_duuchin/view/root_pages/profile/ProfilePage.dart';
import 'package:flutter_duuchin/view/root_pages/tiny_video/TinyVideoPage.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'package:ripple_backdrop_animate_route/ripple_backdrop_animate_route.dart';

// 导航资源集合
const List<Map> _bottomBarList = [
  {
    'icon': 'home.png',
    'activeIcon': 'home_active.png',
    'label': '首页',
  },
  {
    'icon': 'music.png',
    'activeIcon': 'music_active.png',
    'label': '音乐',
  },
  {
    'icon': 'create_media.png',
    'activeIcon': 'create_media.png',
    'label': '',
  },
  {
    'icon': 'tiny_video.png',
    'activeIcon': 'tiny_video_active.png',
    'label': '小视频',
  },
  {
    'icon': 'profile.png',
    'activeIcon': 'profile_active.png',
    'label': '我的',
  }
];

// 应用根页面
class AppPage extends StatefulWidget {
  AppPage({Key key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  // 当前选中页面索引
  int _currentIndex = 0;

  // 页面集合
  final List<Widget> _pageList = [
    HomePage(),
    MusicPage(),
    Container(),
    TinyVideoPage(),
    ProfilePage(),
  ];

  // 点击tabbar切换页面(动画)
  void _onTabbarClick(int index) {
    if (index == 2) {
      return _onCreateMediaClick();
    }
    setState(() {
      _currentIndex = index;
    });
  }

  // 发布媒体
  void _onCreateMediaClick() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (BuildContext context) {
    //     return CreateMedia();
    //   }),
    // );
    Navigator.of(context).push(TransparentRoute(
      builder: (BuildContext context) => RippleBackdropAnimatePage(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.image),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.video_call),
                onPressed: () {},
              ),
            ],
          ),
        ),
        childFade: true,
        duration: 300,
        blurRadius: 20.0,
        bottomButton: const Icon(Icons.close),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProsteIndexedStack(
        index: _currentIndex,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems(),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onTabbarClick,
      ),
      floatingActionButton: _createMediaButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // 发布媒体按钮
  Widget _createMediaButton() {
    return Container(
      width: 44,
      height: 44,
      margin: EdgeInsets.only(top: 56),
      child: FloatingActionButton(
        backgroundColor: DQColor.nav,
        elevation: 0,
        child: Image.asset('assets/images/icons/create_media.png'),
        onPressed: _onCreateMediaClick,
      ),
    );
  }

  // 生成底部导航
  List<BottomNavigationBarItem> _bottomNavigationBarItems() {
    return _bottomBarList.map((item) {
      return BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/icons/' + item['icon'],
          width: 24,
          height: 24,
        ),
        activeIcon: Image.asset(
          'assets/images/icons/' + item['activeIcon'],
          width: 24,
          height: 24,
        ),
        label: item['label'],
        tooltip: '',
      );
    }).toList();
  }
}
