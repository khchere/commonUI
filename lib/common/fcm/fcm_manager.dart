// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:newproject/app.dart';
// import 'package:common_ui/common/extension/snackbar_context_extension.dart';
// import 'package:common_ui/common/util/async/cli_async.dart';
//
// import '../../utils/Logger.dart';
//
// class FcmManager {
//   static void reuestPermission() {
//     // FCM 푸시 알림 권한 요청
//     FirebaseMessaging.instance.requestPermission();
//   }
//
//   static void initialize() async {
//     // Foreground 상태에서 FCM 메시지 수신
//     FirebaseMessaging.onMessage.listen((message) {
//       final title = message.notification?.title;
//       if (title != null) {
//         App.navigatorKey.currentContext?.showSnackbar(title);
//       }
//       Log.d('receive message: $message');
//     });
//
//     // Background 상태에서 FCM 메시지 수신
//     FirebaseMessaging.onBackgroundMessage((message) async {
//       // App.navigatorKey.currentContext!.go((message.data['deeplink']));
//       Log.d('receive message: $message');
//     });
//
//     // 앱이 종료된 상태에서 FCM 메시지 수신
//     final firstMessage = await FirebaseMessaging.instance.getInitialMessage();
//     if (firstMessage != null) {
//       await sleepUntil(() =>
//           App.navigatorKey.currentContext != null &&
//           App.navigatorKey.currentContext!.mounted);
//       final context = App.navigatorKey.currentContext;
//       if (context != null && context.mounted) {
//         // App.navigatorKey.currentContext?.go((firstMessage.data['deeplink']));
//         Log.d('receive message: $firstMessage');
//       }
//     }
//
//     // FCM 토큰 가져오기
//     String? _fcmToken = await FirebaseMessaging.instance.getToken();
//     FirebaseMessaging.instance.onTokenRefresh.listen((event) {
//       // api로 전송
//     });
//     Log.d('FCM Token: $_fcmToken');
//   }
// }
