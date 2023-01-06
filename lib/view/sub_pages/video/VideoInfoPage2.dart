import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/full_screen_page/FullScreenPage.dart';
import 'package:flutter_duuchin/models/VideoModel.dart';
import 'package:flutter_duuchin/utils/util.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoInfoPage extends StatefulWidget {
  final VideoListItem videoListItem;
  VideoInfoPage({Key key, this.videoListItem}) : super(key: key);

  @override
  _VideoInfoPageState createState() => _VideoInfoPageState();
}

class _VideoInfoPageState extends State<VideoInfoPage> {
  // 播放器实例
  VideoPlayerController _videoPlayerController;
  // 播放器初始化的Future
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // 播放器控制器
    _videoPlayerController = VideoPlayerController.network(
      widget.videoListItem?.videoUrl,
    );
    // 播放器初始化
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    // 播放器完成初始化
    _initializeVideoPlayerFuture.then((_) {
      setState(() => _videoPlayerController.play());
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  // 播放或暂停
  void _onPlayOrPause() {
    setState(() {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
      } else {
        _videoPlayerController.play();
      }
    });
  }

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
        _playerBox(
          children: [
            _buildVideo(
              child: VideoPlayer(_videoPlayerController),
              onTap: _onPlayOrPause,
            ),
            _playIcon(
              onTap: _onPlayOrPause,
            ),
            _loading(),
          ],
        ),
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
      future: _initializeVideoPlayerFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // 初始化完 展示播放器
          return GestureDetector(
            onTap: _onPlayOrPause,
            child: child,
          );
        } else {
          // 则展示封面
          return FadeInImage.assetNetwork(
            placeholder: 'assets/images/common/lazy-2.png',
            image: networkImageToDefault(widget.videoListItem?.coverPictureUrl),
            fit: BoxFit.cover,
          );
        }
      },
    );
  }

  // 播放按钮
  Widget _playIcon({GestureTapCallback onTap}) {
    // 初始化完成 并且暂停了 则展示播放按钮
    if (_videoPlayerController.value.isInitialized &&
        !_videoPlayerController.value.isPlaying) {
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
    if (_videoPlayerController.value.isBuffering) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    // 则展示空组件
    return SizedBox.shrink();
  }
}
