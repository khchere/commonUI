import 'package:alice/alice.dart';
import 'package:alice_dio/alice_dio_adapter.dart';
import 'package:common_ui/common/network/dio_api_service.dart';
import 'package:flutter/widgets.dart';

class AliceLog {
  static void setAlice(GlobalKey<NavigatorState> navigatorKey) {
    final alice = Alice();
    alice.setNavigatorKey(navigatorKey);
    AliceDioAdapter aliceDioAdapter = AliceDioAdapter();
    alice.addAdapter(aliceDioAdapter);
    DioApiService.instance.dio.interceptors.add(aliceDioAdapter);
  }
}
