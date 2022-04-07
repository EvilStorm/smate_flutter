import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:loggy/loggy.dart';

class FCMTokenManager {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await checkPermission();
    await _tokenChangeListen();
    await getToken();
    _addMessageReceiver();
  }

  Future<String?> getToken() async {
    var token = await messaging.getToken();
    logDebug("token: $token");
    return token;
  }

  Future<bool> checkPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      logDebug('User granted permission');
      return true;
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      logDebug('User granted provisional permission');
      return true;
    } else {
      logDebug('User declined or has not accepted permission');
      return false;
    }
  }

  void _addMessageReceiver() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logDebug('Got a message whilst in the foreground!');
      logDebug('Message data: ${message.data}');

      if (message.notification != null) {
        logDebug(
            'Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> _tokenChangeListen() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      //TODO 사용자 토큰 값 변경해야 됨.
      logDebug(" FirebaseMessaging onTokenRefresh: $token");
    });
  }
}
