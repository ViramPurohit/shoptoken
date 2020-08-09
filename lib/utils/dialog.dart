import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Dialogs {
  showLoaderDialog(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AlertDialog alert = AlertDialog(
        content: new Row(
          children: [
            Container(
                margin: EdgeInsets.all(10), child: CircularProgressIndicator()),
            Container(margin: EdgeInsets.all(10), child: Text("Loading...")),
          ],
        ),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    });
  }

  dismissLoaderDialog(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context);
    });
  }
}
