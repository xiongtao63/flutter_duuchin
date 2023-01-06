import 'package:flutter/material.dart';
import 'package:flutter_duuchin/utils/util.dart';

enum ImageType {
  error,
  network,
  empty,
  loading,
}

const List<String> imageList = [
  'assets/images/common/error.png',
  'assets/images/common/network.png',
  'assets/images/common/empty.png',
  'assets/images/common/logo.png',
];

// 反馈组件
class FeedBack extends StatelessWidget {
  final ImageType imageType;
  final String description;
  final bool showButton;
  final String buttonText;
  final VoidCallback onTap;

  const FeedBack({
    Key key,
    this.imageType = ImageType.loading,
    this.description,
    this.showButton = false,
    this.buttonText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageList[imageType.index],
            width: toRpx(size: 216),
            fit: BoxFit.fitWidth,
          ),
          Offstage(
            offstage: description == null || description.isEmpty,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('$description'),
            ),
          ),
          Offstage(
            offstage: !showButton || buttonText == null || buttonText.isEmpty,
            child: Column(
              children: [
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: onTap,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  child: Text('$buttonText'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
