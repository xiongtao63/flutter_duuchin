import 'package:flutter/material.dart';
import 'package:flutter_duuchin/logic/VideoInfoLogic.dart';
import 'package:flutter_duuchin/state/VideoInfoState.dart';
import 'package:flutter_duuchin/utils/util.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class Player extends StatelessWidget {
  final VideoInfoLogic videoInfoLogic = Get.find();
  // 基于控制器查找状态层
  final VideoInfoState videoInfoState = Get.find<VideoInfoLogic>().state;

  @override
  Widget build(BuildContext context) {
    return _playerBox(
      children: [
        _buildVideo(
          child: VideoPlayer(videoInfoState.videoPlayerController),
          onTap: videoInfoLogic.onPlayOrPause,
        ),
        _playIcon(
          onTap: videoInfoLogic.onPlayOrPause,
        ),
        _loading(),
      ],
    );
  }

  // 播放器容器
  Widget _playerBox({List<Widget> children = const <Widget>[]}) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: children,
      ),
    );
  }

  // 初始化播放器
  Widget _buildVideo({Widget child, GestureTapCallback onTap}) {
    return FutureBuilder(
      future: videoInfoState.initializeVideoPlayerFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // 初始化完 展示播放器
          return GestureDetector(
            onTap: videoInfoLogic.onPlayOrPause,
            child: child,
          );
        } else {
          // 则展示封面
          return FadeInImage.assetNetwork(
            placeholder: 'assets/images/common/lazy-2.png',
            image: networkImageToDefault(
                videoInfoState.videoListItem?.coverPictureUrl),
            fit: BoxFit.cover,
          );
        }
      },
    );
  }

  // 播放按钮
  Widget _playIcon({GestureTapCallback onTap}) {
    // 初始化完成 并且暂停了 则展示播放按钮
    if (videoInfoState.videoPlayerController.value.isInitialized &&
        !videoInfoState.videoPlayerController.value.isPlaying) {
      return Center(
        child: GestureDetector(
          onTap: onTap,
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(
              'assets/images/icons/play_plus.png',
              width: toRpx(size: 100),
              height: toRpx(size: 100),
            ),
          ),
        ),
      );
    }
    // 则展示空组件
    return SizedBox.shrink();
  }

  // 缓冲中
  Widget _loading() {
    if (videoInfoState.videoPlayerController.value.isBuffering) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    // 则展示空组件
    return SizedBox.shrink();
  }
}
