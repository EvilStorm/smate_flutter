import 'package:flutter/material.dart';
import 'package:smate/contants/constants.dart';

class EmptyView extends StatelessWidget {
  final String title;
  final String message;
  final String? btnText;
  final Function? onClick;
  const EmptyView({
    Key? key,
    required this.title,
    required this.message,
    this.onClick,
    this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        const SizedBox(
          height: Constants.sapceGap * 4,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: const Color(0xFF434343), height: 1.5),
        ),
        const SizedBox(
          height: Constants.sapceGap * 4,
        ),
        Visibility(
          visible: btnText != null,
          child: ElevatedButton(
            onPressed: () {
              onClick?.call();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.sapceGap * 4,
                  vertical: Constants.sapceGap),
              child: Text(
                btnText ?? "",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .apply(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
