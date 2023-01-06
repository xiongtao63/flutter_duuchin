import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_duuchin/AppPage.dart';
import 'package:flutter_duuchin/config/DQColor.dart';
import 'package:flutter_duuchin/routes/app_routes.dart';
import 'package:get/get.dart';

// 过渡页
class TansitPage extends StatefulWidget {
  TansitPage({Key key}) : super(key: key);

  @override
  _TansitPageState createState() => _TansitPageState();
}

class _TansitPageState extends State<TansitPage> {
  Timer _timer;
  int _currentTime = 6;

  @override
  void initState() {
    super.initState();
    // 倒计时
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _currentTime--;
      });
      if (_currentTime <= 0) {
        timer.cancel();
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (BuildContext context) {
        //     return AppPage();
        //   }),
        //   (route) => false,
        // );
        Get.offNamed(AppRoutes.app);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/common/page.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 10,
            child: InkWell(
              child: Chip(
                label: Column(
                  children: [
                    Text('跳过'),
                    Text('${_currentTime}s'),
                  ],
                ),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                backgroundColor: DQColor.active,
              ),
              onTap: () {
                _timer.cancel();
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (BuildContext context) {
                //     return AppPage();
                //   }),
                //   (route) => false,
                // );
                Get.offNamed(AppRoutes.app);
              },
            ),
          ),
        ],
      ),
    );
  }
}
