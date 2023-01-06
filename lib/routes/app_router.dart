import 'package:flutter_duuchin/AppPage.dart';
import 'package:flutter_duuchin/TansitPage.dart';
import 'package:flutter_duuchin/view/sub_pages/video/VideoInfoPage.dart';

import 'app_routes.dart';
import 'package:get/get.dart';

class AppRouter {
  // 初始路由
  static const String initialRoute = AppRoutes.transit;
  // 404
  static final GetPage unknownRoute = GetPage(
    name: AppRoutes.notfound,
    page: () => AppPage(),
  );
  // 路由页面
  static final List<GetPage<dynamic>> getPages = [
    GetPage(
      name: AppRoutes.transit,
      page: () => TansitPage(),
    ),
    GetPage(
      name: AppRoutes.app,
      page: () => AppPage(),
    ),
    GetPage(
      name: AppRoutes.videoInfo,
      page: () => VideoInfoPage(),
    ),
  ];
}
