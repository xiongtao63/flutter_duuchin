import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_duuchin/routes/app_router.dart';
import 'package:get/get.dart';
import 'package:flutter_duuchin/config/DQColor.dart';

void main() {
  runApp(MyApp());

  if (Platform.isAndroid) {
    // 沉浸式状态栏
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,

      /// 这是设置状态栏的图标和字体的颜色
      /// Brightness.light  一般都是显示为白色
      /// Brightness.dark 一般都是显示为黑色
      statusBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatelessWidget {
  // 参考文档 https://api.flutter.dev/flutter/material/ThemeData-class.html
  final ThemeData _themeData = ThemeData(
    primaryColor: DQColor.primary, // 主题色
    scaffoldBackgroundColor: DQColor.page, // 脚手架下的页面背景色
    indicatorColor: DQColor.active, // 选项卡栏中所选选项卡指示器的颜色。
    // ElevatedButton 主题
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        // 文字颜色
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.white;
          } else {
            return null;
          }
        }),
        // 背景色
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return DQColor.danger.withOpacity(0.5);
          } else {
            return DQColor.danger;
          }
        }),
      ),
    ),
    accentColor: DQColor.primary, // 小部件的前景色（旋钮，文本，过度滚动边缘效果等）
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.white.withOpacity(0.5),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: DQColor.unactive,
      ),
    ),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: DQColor.unactive,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(
        fontSize: 18,
      ),
      labelPadding: EdgeInsets.symmetric(horizontal: 12),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: DQColor.nav,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: DQColor.nav,
      selectedItemColor: DQColor.active,
      unselectedItemColor: DQColor.unactive,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '读琴',
      theme: _themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.initialRoute,
      unknownRoute: AppRouter.unknownRoute,
      getPages: AppRouter.getPages,
    );
    // return MaterialApp(
    //   title: '读琴',
    //   theme: _themeData,
    //   debugShowCheckedModeBanner: false,
    //   home: TansitPage(),
    // );
  }
}
