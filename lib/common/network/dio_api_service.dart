import 'dart:io';

import 'package:common_ui/common/network/api_error.dart';
import 'package:common_ui/common/network/simple_result.dart';
import 'package:common_ui/common/util/logger.dart';
import 'package:common_ui/widget/dialog/d_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nav/nav.dart';

class DioApiService {
  final String base_url;
  static final DioApiService _instance =
      DioApiService.internal('https://snssaradio.nexon.com');
  DioApiService.internal(this.base_url) {
    _addInterceptors();
  } // private로 두면 자식 클래스에서 접근 불가

  static DioApiService get instance => _instance;
  late final dio;

  bool _initialized = false;
  // static DioApiService instance = DioApiService._();
  // DioApiService._() {
  //   _addInterceptors();
  // }
  void _addInterceptors() {
    if (!_initialized) {
      dio = Dio(BaseOptions(
        // baseUrl: Platform.isAndroid ? nexon_url : 'http://localhost:8080',
        baseUrl: base_url,
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json; charset=utf-8',
          'User-Agent': '(${Platform.executable};)',
        },
        responseType: ResponseType.json,
      ));

      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          var fieldsString = '';
          fieldsString +=
              '📌 [Http onRequest]: ${options.method} ${options.uri}\n';

          if (options.data is FormData) {
            fieldsString += '📌 [Params Fields]:\n';
            for (var field in options.data.fields) {
              fieldsString += "  ▶ ${field.key}: ${field.value}\n";
            }
          } else {
            print("📦 Data: ${options.data}");
          }

          Log.d(fieldsString);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          var responseData = '';
          responseData +=
              '📌 [Http onResponse]: ${response.statusCode} ${response.requestOptions.uri}\n';
          responseData += '${response.data}\n';
          Log.d(responseData);
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          Log.e(
              '❌ Http onError: ${e.message} ${e.requestOptions.uri}]\n Http onError Data: ${e.requestOptions.data}');
          return handler.next(e);
        },
      ));
      _initialized = true;
    }
  }

  // api request를 공통으로 처리하는 함수
  static Future<SimpleResult<T, ApiError>> tryRequest<T>(
      Future<SimpleResult<T, ApiError>> Function() apiLogic) async {
    try {
      return await apiLogic();
    } on DioException catch (e) {
      showDialog(
          context: Nav.globalContext,
          builder: (context) => MessageDialog(e.message));
      return SimpleResult.failure(ApiError.createErrorResult(e));
    } catch (e) {
      return SimpleResult.failure(
          ApiError(message: 'unknown error ${e.toString()}'));
    }
  }
}
