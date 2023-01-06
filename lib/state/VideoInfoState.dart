import 'package:flutter_duuchin/models/VideoModel.dart';
import 'package:video_player/video_player.dart';

/// 视频详情状态
class VideoInfoState {
  VideoListItem videoListItem;
  // 播放器实例
  VideoPlayerController videoPlayerController;
  // 播放器初始化的Future
  Future<void> initializeVideoPlayerFuture;
}
