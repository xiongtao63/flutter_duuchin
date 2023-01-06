import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/full_screen_page/FullScreenPage.dart';
import 'package:flutter_duuchin/components/video_player/player.dart';
import 'package:flutter_duuchin/logic/VideoInfoLogic.dart';
import 'package:flutter_duuchin/state/VideoInfoState.dart';
import 'package:get/get.dart';

class VideoInfoPage extends StatelessWidget {
  // 初始化控制器
  final VideoInfoLogic videoInfoLogic = Get.put(VideoInfoLogic());
  // 基于控制器查找状态层
  final VideoInfoState videoInfoState = Get.find<VideoInfoLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FullScreenPage(
          appBarHeight: 44,
          leadingIcon: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () => Get.back(),
          ),
          actionIcon: IconButton(
            icon: Icon(Icons.more_horiz),
            color: Colors.white,
            onPressed: () {},
          ),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Player(),
      ],
    );
  }
}
