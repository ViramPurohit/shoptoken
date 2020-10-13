import 'package:flutter/material.dart';
import 'package:Retailer/models/bookslots.dart';
import 'package:Retailer/widgets/text_style.dart';

class BookConfirmScreen extends StatelessWidget {
  //requiring the list of todos
  BookConfirmScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.all(10.0),
            child: Center(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(
                      'bookSlotsResponse.bookingresult.message',
                      style:
                          getTextStyle().copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "TICKET NUMBER",
                      style: getTextStyle()
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ]))));
  }
}
