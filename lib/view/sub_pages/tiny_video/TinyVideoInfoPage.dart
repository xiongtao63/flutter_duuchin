import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/feedback/PageFeedBack.dart';
import 'package:flutter_duuchin/components/tiny_video_player/TinyVideoPlayer.dart';
import 'package:flutter_duuchin/models/TinyVideoModel.dart';
import 'package:flutter_duuchin/services/TinyVideoService.dart';

/// 小视频详情
class TinyVideoInfoPage extends StatefulWidget {
  final int infoId;
  TinyVideoInfoPage({Key key, this.infoId}) : super(key: key);

  @override
  _TinyVideoInfoPageState createState() => _TinyVideoInfoPageState();
}

class _TinyVideoInfoPageState extends State<TinyVideoInfoPage> {
  TinyVideoListItem _tinyVideoInfo;
  bool loading = true;
  bool error = false;
  String errorMsg;

  @override
  void initState() {
    super.initState();
    _getTinyVideoInfo();
  }

  Future _getTinyVideoInfo() async {
    try {
      Map<String, dynamic> info =
          await TinyVideoService.getTinyVideoInfo(widget.infoId);

      setState(() {
        _tinyVideoInfo = TinyVideoListItem.fromJson(info);
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

  @override
  Widget build(BuildContext context) {
    Widget _body;
    if (loading) {
      _body = PageFeedBack(firstRefresh: true).build();
    } else if (error) {
      _body = PageFeedBack(
        loading: false,
        error: true,
        errorMsg: errorMsg,
        onErrorTap: () {
          setState(() {
            loading = true;
            error = false;
          });
          _getTinyVideoInfo();
        },
      ).build();
    } else {
      _body = TinyVideoPlayer(tinyVideoListItem: _tinyVideoInfo);
    }

    return Scaffold(
      body: Stack(
        children: [
          _body,
          SafeArea(
            child: SizedBox(
              height: kToolbarHeight,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
