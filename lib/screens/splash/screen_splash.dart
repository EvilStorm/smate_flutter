import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:smate/controllers/controller_splash.dart';
import 'package:smate/screens/common/widget_notify.dart';
import 'package:smate/screens/common/widget_term.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    initializeDateFormatting(Localizations.localeOf(context).languageCode);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: controller.obx((state) {
              return Stack(
                children: [
                  Visibility(
                    visible: !state!.processState[1],
                    child: WidgetNotify(
                      data: state.notify,
                      showTitle: true,
                      callback: (seq) {
                        state.setProcessStateChanged(1, true);
                        controller.readNotify(seq);
                        controller.checkProcess();
                      },
                    ),
                  ),
                  Visibility(
                    visible: !state.processState[2],
                    child: TermWidget(
                      data: state.term,
                      justShow: false,
                      callback: (seq) {
                        state.setProcessStateChanged(2, true);
                        controller.agreeTerm(seq);
                        controller.checkProcess();
                      },
                    ),
                  )
                ],
              );
            }, onLoading: loadingWidget()),
          ),
        ),
      ),
    );
  }

  Center loadingWidget() {
    return const Center(
      child: Text('로딩'),
    );
  }
}
