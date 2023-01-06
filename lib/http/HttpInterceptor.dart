import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'HttpException.dart';

// 自定义拦截器
class HttpInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    super.onRequest(options, handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    Map<String, dynamic> data = response.data;
    if (data['code'] != 0) {
      HttpException httpException = HttpException(
        code: data['code'],
        msg: data['msg'],
      );
      throw httpException;
    } else {
      super.onResponse(response, handler);
    }
  }

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    // error统一处理
    HttpException httpException = HttpException.create(err);
    // 错误提示
    debugPrint('DioError===: ${httpException.toString()}');
    err.error = httpException;
    super.onError(err, handler);
  }
}
