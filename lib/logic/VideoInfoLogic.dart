import 'package:flutter_duuchin/state/VideoInfoState.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

/// 视频详情控制器
class VideoInfoLogic extends GetxController {
  final VideoInfoState state = VideoInfoState();

  @override
  void onReady() {
    super.onReady();
    // 获取参数
    Map arg = Get.arguments;
    state.videoListItem = arg['videoListItem'];

    // 播放器控制器
    state.videoPlayerController = VideoPlayerController.network(
      state.videoListItem?.videoUrl,
    );
    // 播放器初始化
    state.initializeVideoPlayerFuture =
        state.videoPlayerController.initialize();
    // 播放器完成初始化
    state.initializeVideoPlayerFuture.then((_) {
      state.videoPlayerController.play();
    });
  }

  @override
  void dispose() {
    state.videoPlayerController.dispose();
    super.dispose();
  }

  // 播放或暂停
  void onPlayOrPause() {
    if (state.videoPlayerController.value.isPlaying) {
      state.videoPlayerController.pause();
    } else {
      state.videoPlayerController.play();
    }
  }
}
