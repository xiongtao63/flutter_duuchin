import 'dart:math';

import 'package:get/get.dart';

/// 阅读数转换 比如10w
String formatCharCount(int count) {
  if (count == null || count < 0 || count.isNaN) {
    return '0';
  }
  String strCount = count.toString();
  if (strCount.length >= 5) {
    // 如：123456 => 12
    String prefix = strCount.substring(0, strCount.length - 4);
    if (strCount.length == 5) {
      prefix += '.' + strCount[1];
    }
    if (strCount.length == 6) {
      prefix += '.' + strCount[2];
    }
    return prefix + 'w';
  }
  return strCount;
}

/// 秒数转 时:分:秒
String secondsToTime(int seconds) {
  if (seconds == null || seconds <= 0 || seconds.isNaN) {
    return '00:00';
  }
  // 时分数
  int hours = 0;
  // 分钟数
  int minutes = 0;
  // 除整数分钟外剩余的秒数
  int remainingSeconds = 0;

  hours = (seconds / 60 / 60).floor();
  minutes = (seconds / 60 % 60).floor();
  remainingSeconds = seconds % 60;

  // 返回 时:分:秒
  return '${formatNumber(hours)}:${formatNumber(minutes)}:${formatNumber(remainingSeconds)}';
}

/// 个数补零
String formatNumber(int count) {
  String strCount = count.toString();
  return strCount.length > 1 ? strCount : '0$strCount';
}

/// 随机获取指定返回内的数值
///
/// from [min] 含，to [max] 含
int getRandomRangeInt(int min, int max) {
  final Random random = new Random();
  return min + random.nextInt(max + 1 - min);
}

/// 转为 rpx 单位
///
/// [size] 设计稿上的大小
///
/// [width] 设计稿尺寸
double toRpx({double size = 0, double width = 750}) {
  // 原生：MediaQuery.of(context).size.width / 750;
  double rpx = Get.width / width;
  return size * rpx;
}

/// 网络图默认图
String networkImageToDefault(String src) {
  return src ??
      'https://pic1.zhimg.com/80/v2-6afa72220d29f045c15217aa6b275808_720w.jpg?source=1940ef5c';
}
