import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/sign/screen_sign.dart';

Future<void> main() async {
  Loggy.initLoggy();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setFCM();

  runApp(const MyApp());
}

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> setFCM() async {
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
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  var token = await messaging.getToken();
  print("Token / : $token");
  FirebaseMessaging.instance.onTokenRefresh.listen((event) {
    print("Token: $token");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScreenSign(),
    );
  }
}
