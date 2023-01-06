import 'package:flutter/material.dart';

// 固定高度的 tabbar
class PreferredTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  final List<Widget> tabs;
  final double height;

  const PreferredTabBar({
    Key key,
    @required this.tabController,
    @required this.tabs,
    this.height = 44,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: SizedBox(
        height: height,
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          tabs: tabs,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
