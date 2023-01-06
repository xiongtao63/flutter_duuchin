import 'package:flutter/material.dart';
import 'package:flutter_duuchin/components/feedback/PageFeedBack.dart';
import 'package:flutter_duuchin/components/singer_card/SingerCard.dart';
import 'package:flutter_duuchin/components/song_card/SongCard.dart';
import 'package:flutter_duuchin/components/song_sheet_card/SongSheetCard.dart';
import 'package:flutter_duuchin/models/SingerModel.dart';
import 'package:flutter_duuchin/models/SongModel.dart';
import 'package:flutter_duuchin/models/SongSheetModel.dart';
import 'package:flutter_duuchin/services/SingerService.dart';
import 'package:flutter_duuchin/services/SongService.dart';
import 'package:flutter_duuchin/services/SongSheetService.dart';

// 音乐推荐
class MusicRecommendPage extends StatefulWidget {
  MusicRecommendPage({Key key}) : super(key: key);

  @override
  _MusicRecommendPageState createState() => _MusicRecommendPageState();
}

class _MusicRecommendPageState extends State<MusicRecommendPage>
    with AutomaticKeepAliveClientMixin {
  // 列表数组模型
  List<SongListItem> _songList = SongList([]).list;
  List<SingerListItem> _singerList = SingerList([]).list;
  List<SongSheetListItem> _songSheetList = SongSheetList([]).list;
  bool loading = true;
  bool error = false;
  String errorMsg;

  @override
  void initState() {
    super.initState();
    _getAll();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 统一请求
  Future _getAll() async {
    try {
      List<dynamic> resultModel = await Future.wait([
        _getSongs(),
        _getSingers(),
        _getSongSheets(),
      ]);
      setState(() {
        _songList = resultModel[0].list;
        _singerList = resultModel[1].list;
        _songSheetList = resultModel[2].list;
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

  // 获取歌曲数据
  Future _getSongs() async {
    Map<String, dynamic> result = await SongService.getSongs();
    List<dynamic> songList = result['list'];
    SongList songListModel = SongList.fromJson(songList);
    return songListModel;
  }

  // 获取歌手数据
  Future _getSingers() async {
    Map<String, dynamic> result = await SingerService.getSingers();
    List<dynamic> singerList = result['list'];
    SingerList singerListModel = SingerList.fromJson(singerList);
    return singerListModel;
  }

  // 获取歌单数据
  Future _getSongSheets() async {
    Map<String, dynamic> result = await SongSheetService.getSongSheets();
    List<dynamic> songSheetList = result['list'];
    SongSheetList songSheetListModel = SongSheetList.fromJson(songSheetList);
    return songSheetListModel;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (loading) {
      return PageFeedBack(firstRefresh: true).build();
    }
    if (error) {
      return PageFeedBack(
        loading: false,
        error: true,
        errorMsg: errorMsg,
        onErrorTap: () {
          setState(() {
            loading = true;
            error = false;
          });
          _getAll();
        },
      ).build();
    }
    return ListView(
      children: [
        _title('音乐推荐'),
        _songRecommend(),
        _title('歌手推荐'),
        _singerRecommend(),
        _title('歌单推荐'),
        _songSheetRecommend(),
        SizedBox(height: 7),
      ],
    );
  }

  // 标题
  Widget _title(String title) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(title),
    );
  }

  // 歌曲推荐
  Widget _songRecommend() {
    return Column(
      children: List.generate(_songList.length, (index) {
        return Column(
          children: [
            SongCard(songListItem: _songList[index]),
            Offstage(
              offstage: _songList.length - 1 == index,
              child: SizedBox(height: 7),
            ),
          ],
        );
      }),
    );
  }

  // 歌手推荐
  Widget _singerRecommend() {
    return AspectRatio(
      aspectRatio: 750 / 498,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _singerList.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          return AspectRatio(
            aspectRatio: 375 / 498,
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 10),
              color: Colors.white,
              child: SingerCard(singerListItem: _singerList[index]),
            ),
          );
        },
      ),
    );
  }

  // 歌单推荐
  Widget _songSheetRecommend() {
    return AspectRatio(
      aspectRatio: 750 / 498,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _songSheetList.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          return AspectRatio(
            aspectRatio: 375 / 498,
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 10),
              color: Colors.white,
              child: SongSheetCard(songSheetListItem: _songSheetList[index]),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
