import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';

// Must be top-level function
dynamic _parseAndDecode(String response) => jsonDecode(response);

Future parseJson(String text) => compute(_parseAndDecode, text);

@singleton
class AppDio extends DioForNative {
  BaseOptions get _baseOptions => BaseOptions(
        receiveTimeout: const Duration(milliseconds: 60000),
        connectTimeout: const Duration(milliseconds: 60000),
        sendTimeout: const Duration(milliseconds: 60000),
        followRedirects: false,
      );

  AppDio() {
    (transformer as BackgroundTransformer).jsonDecodeCallback = parseJson;
    options = _baseOptions;
  }
}
