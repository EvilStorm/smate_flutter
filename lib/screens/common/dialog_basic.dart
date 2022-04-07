import 'package:flutter/material.dart';

class BasicDialog extends StatelessWidget {
  final String message;
  final String? title;
  final String? leftBtnTitle;
  final Function? leftBtnAction;
  final String? rightBtnTitle;
  final Function? rightBtnAction;
  final double? height;
  final bool rightBtnAccent;
  final bool leftBtnAccent;

  const BasicDialog({
    Key? key,
    required this.message,
    this.title,
    this.leftBtnTitle,
    this.leftBtnAction,
    this.rightBtnTitle,
    this.rightBtnAction,
    this.height,
    this.rightBtnAccent = false,
    this.leftBtnAccent = false,
  }) : super(key: key);

  double getDefaultHeight() {
    return title != null ? 210 : 180;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: height ?? getDefaultHeight(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Visibility(
                  visible: title != null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  )),
              Expanded(
                child: Center(
                  child: Text(
                    message.replaceAll("\\n", "\n"),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.black,
                        height: 1.4,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              buttonSection()
            ],
          ),
        ),
      ),
    );
  }

  Row buttonSection() {
    return Row(
      children: [
        Visibility(
            visible: leftBtnTitle != null,
            child: Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: leftBtnAccent
                          ? MaterialStateProperty.all(Colors.red)
                          : null,
                    ),
                    onPressed: () => leftBtnAction?.call(),
                    child: Text(leftBtnTitle ?? "")))),
        Visibility(
            visible: leftBtnTitle != null,
            child: const SizedBox(
              width: 16.0,
            )),
        Visibility(
          visible: rightBtnTitle != null,
          child: Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: rightBtnAccent
                        ? MaterialStateProperty.all(Colors.red)
                        : null,
                  ),
                  onPressed: () => rightBtnAction?.call(),
                  child: Text(rightBtnTitle ?? ""))),
        ),
      ],
    );
  }
}
