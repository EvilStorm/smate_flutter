import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smate/contants/constants.dart';

class ThridPartySignInButton extends StatelessWidget {
  final VoidCallback callback;
  final String svgImage;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? textColor;
  final String title;

  const ThridPartySignInButton({
    Key? key,
    required this.svgImage,
    this.iconColor,
    required this.title,
    required this.callback,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          primary: backgroundColor,
        ),
        onPressed: () {
          callback();
        },
        child: Padding(
          padding: const EdgeInsets.all(Constants.sapceGap / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 30,
                child: SvgPicture.asset(
                  svgImage,
                  width: 20,
                  height: 20,
                  color: iconColor,
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.sapceGap / 2),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        ));
  }
}
