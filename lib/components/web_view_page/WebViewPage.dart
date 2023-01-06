import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

/// webview 封装
class WebViewPage extends StatefulWidget {
  final String initialUrl;

  WebViewPage({Key key, this.initialUrl}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.initialUrl,
      userAgent: 'Android Duuchin',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController controller) {
        _webViewController = controller;
      },
      onProgress: (int progress) {
        print('progress=====>$progress');
      },
      onPageStarted: (String url) {
        print('onPageStarted=====>$url');
      },
      onPageFinished: (String url) {
        print('onPageFinished=====>$url');
      },
      onWebResourceError: (WebResourceError error) {
        print('error=====>$error');
      },
    );
  }
}
