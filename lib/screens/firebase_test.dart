import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';

class FireBaseTest extends StatefulWidget {
  const FireBaseTest({Key? key}) : super(key: key);

  @override
  State<FireBaseTest> createState() => _FireBaseTestState();
}

class _FireBaseTestState extends State<FireBaseTest> {
  @override
  Widget build(BuildContext context) {
    CollectionReference sample =
        FirebaseFirestore.instance.collection('sample');

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                sample
                    .doc('U04tzQCxABEhMYowPR1M')
                    .set(
                      {
                        'friend': 'dsEIj6Nfe1cwCYAcI2Li',
                      },
                      SetOptions(merge: true),
                    )
                    .then((value) => logInfo('setOK'))
                    .catchError((error) => logError(error));
              },
              child: Text('입력하기'),
            ),
            ElevatedButton(
              onPressed: () {
                sample.get().then((QuerySnapshot querySnapshot) {
                  querySnapshot.docs.forEach((doc) {
                    logInfo('?????????????');
                    logInfo(doc.id);
                  });
                }).catchError((error) => logError(error));
              },
              child: Text('입력하기'),
            ),
          ],
        ),
      ),
    );
  }
}
