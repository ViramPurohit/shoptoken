import 'package:Retailer/utils/dialog.dart';
import 'package:Retailer/widgets/text_style.dart';
import 'package:flutter/material.dart';

class SettingOptions extends StatefulWidget {
  //requiring the list of todos
  SettingOptions({Key key}) : super(key: key);

  @override
  _SettingOptionsState createState() => new _SettingOptionsState();
}

class _SettingOptionsState extends State<SettingOptions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Container(
              child: Column(
        children: <Widget>[
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10, bottom: 10),
              margin: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 40, bottom: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    'Change shop slot amount',
                    style: getTextStyle().copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      child: new Icon(Icons.chevron_right))
                ],
              ),
            ),
            onTap: () {
              showSlotList(context);
            },
          ),
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10, bottom: 10),
              margin: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 40, bottom: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    'Enable holiday for today',
                    style: getTextStyle().copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      child: new Icon(Icons.chevron_right))
                ],
              ),
            ),
            onTap: () {},
          )
        ],
      ))),
    );
  }

  List<int> getSlotList() {
    var list = List<int>();
    for (var i = 1; i <= 60; i++) {
      if (i % 5 == 0) {
        list.add(i);
      }
    }

    return list;
  }

  Future<void> showSlotList(BuildContext context) async {
    var value = await Dialogs().selectTimeSlot(context, getSlotList());

    print("value Final $value");
  }
}
