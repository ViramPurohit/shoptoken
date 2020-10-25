import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Dialogs {
  Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please wait...",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }

  dismissLoadingDialog(BuildContext currentContext) {
    Navigator.of(currentContext, rootNavigator: true).pop(); //close the dialoge
  }

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

  showAlertMsgDialog(BuildContext context, title, msg) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AlertDialog alert = AlertDialog(
        title: new Text(title),
        content: new Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
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

  Future<int> selectTimeSlot(BuildContext context, list) async {
    var _currentIndex = -1;
    var slotvalue = 0;
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('Select TimeSlot'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  child: Text('CANCEL'),
                ),
                FlatButton(
                  onPressed: () {
                    print("Navigator.pop value $slotvalue");
                    Navigator.pop(context, slotvalue);
                  },
                  child: Text('OK'),
                ),
              ],
              content: Container(
                width: double.minPositive,
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                      value: index,
                      groupValue: _currentIndex,
                      title: Text(list[index].toString()),
                      onChanged: (val) {
                        setState(() {
                          _currentIndex = val;
                          print("_currentIndex $_currentIndex");
                          slotvalue = list[index];
                          print("value $slotvalue");
                        });
                      },
                    );
                  },
                ),
              ),
            );
          });
        });
    // });
  }

  Future<bool> dialogwithbutton(BuildContext context, title, msg) async {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(title),
              content: new Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                )
              ],
            ));
  }
}
