import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color.fromARGB(155, 68, 68, 68),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CircularProgressIndicator(
          //   strokeWidth: 4,
          //   backgroundColor: Colors.white,
          //   valueColor: AlwaysStoppedAnimation<Color>(
          //       Theme.of(context).backgroundColor),
          // ),
          SpinKitPumpingHeart(
              color: Theme.of(context).primaryColor.withOpacity(0.7)),

          const SizedBox(
            height: 16.0,
          ),
          Text(
            '잠시만 기다려주세요.',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .apply(color: Colors.white),
          )
        ],
      ),
    );
  }
}
