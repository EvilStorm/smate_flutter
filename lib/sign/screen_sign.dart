import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ScreenSign extends StatefulWidget {
  const ScreenSign({Key? key}) : super(key: key);

  @override
  State<ScreenSign> createState() => _ScreenSignState();
}

class _ScreenSignState extends State<ScreenSign> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("SIGN"),
          ElevatedButton(
            onPressed: () async {
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
                if (user == null) {
                  print('User is currently signed out!');
                } else {
                  print('User is signed in!');
                }
              });

              try {
                final userCredential =
                    await FirebaseAuth.instance.signInAnonymously();
                print(userCredential.toString());
                print("Signed in with temporary account.");
              } on FirebaseAuthException catch (e) {
                print(e);
                switch (e.code) {
                  case "operation-not-allowed":
                    print(
                        "Anonymous auth hasn't been enabled for this project.");
                    break;
                  default:
                    print("Unkown error.");
                }
              }
            },
            child: Text('로그인'),
          ),
          ElevatedButton(
            onPressed: () async {
              final out = await FirebaseAuth.instance.signOut();
              print("Signed in Out.");
            },
            child: Text('로그아웃'),
          ),
        ],
      ),
    );
  }
}
