import 'package:flutter/material.dart';

// 发布
class CreateMedia extends StatefulWidget {
  CreateMedia({Key key}) : super(key: key);

  @override
  _CreateMediaState createState() => _CreateMediaState();
}

class _CreateMediaState extends State<CreateMedia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发布'),
      ),
      body: Text('CreateMedia'),
    );
  }
}
