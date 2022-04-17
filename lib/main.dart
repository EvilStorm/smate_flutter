import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/controllers/contoller_user_info.dart';
import 'package:smate/controllers/controller_email_sign_in.dart';
import 'package:smate/controllers/controller_sign.dart';
import 'package:smate/controllers/controller_third_party_signin.dart';
import 'package:smate/firebase_options.dart';
import 'package:smate/models/model_sample.dart';
import 'package:smate/routers.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  Loggy.initLoggy();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setFCM();
  await GetStorage.init();
  final FirebaseApp _initialization = await Firebase.initializeApp();
  FirebaseFirestore.instanceFor(app: _initialization);

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
    logDebug('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    logDebug('User granted provisional permission');
  } else {
    logDebug('User declined or has not accepted permission');
  }

  var token = await messaging.getToken();
  logDebug("Token / : $token");
  FirebaseMessaging.instance.onTokenRefresh.listen((event) {
    logDebug("Token: $token");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    logDebug('Got a message whilst in the foreground!');
    logDebug('Message data: ${message.data}');

    if (message.notification != null) {
      logDebug(
          'Message also contained a notification: ${message.notification!.body!}');
      Fluttertoast.showToast(msg: message.notification!.body ?? "");
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(SignController());
    Get.put(UserInfoController());
    Get.put(ThirdPartySignInController());
    Get.put(EmailSignInController());

    return GetMaterialApp(
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!);
      },
      title: 'StyleMate',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: Routers().allPageRouter,
    );
  }
}
