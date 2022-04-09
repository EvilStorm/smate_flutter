import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';

import '../../models/model_notify.dart';
import 'about_date.dart';

class WidgetNotify extends StatelessWidget {
  final List<NotifyModel>? data;
  final Function? callback;
  final bool showTitle;

  const WidgetNotify({
    Key? key,
    this.data,
    this.callback,
    this.showTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int seq = 0;

    return Container(
        decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Visibility(
              visible: showTitle,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 44),
                  Text('공지사항', style: Theme.of(context).textTheme.headline6),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                  itemCount: data?.length ?? 0,
                  itemBuilder: (context, index) {
                    var item = data![index];
                    if (index == 0) {
                      seq = item.seq ?? 0;
                    }
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: Card(
                        color: Theme.of(context).primaryColor,
                        elevation: 3,
                        child: ExpandablePanel(
                          header: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    AboutDate.dateFormat.format(
                                        item.createdAt ?? DateTime.now()),
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(item.title ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ],
                              )),
                          collapsed: const Text(""),
                          expanded: Html(
                            data: item.say ?? "",
                            style: {
                              "div": Style(
                                fontSize: FontSize.medium,
                              )
                            },
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  child: Text('확인', style: Theme.of(context).textTheme.button),
                  onPressed: () {
                    callback?.call(seq);
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
