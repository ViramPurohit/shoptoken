import 'package:flutter/material.dart';
import 'package:shoptoken/models/bookslots.dart';
import 'package:shoptoken/widgets/text_style.dart';

class BookConfirmScreen extends StatelessWidget {
  final BookSlotsResponse bookSlotsResponse;

  //requiring the list of todos
  BookConfirmScreen({Key key, @required this.bookSlotsResponse})
      : super(key: key);

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
                      bookSlotsResponse.bookingresult.message,
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
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      bookSlotsResponse.bookingresult.ticketNumber.toString(),
                      style: getTextStyle()
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(
                      'Confirmation code on SMS',
                      style:
                          getTextStyle().copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(
                      bookSlotsResponse.bookingresult.confirmCode.toString(),
                      style: getTextStyle()
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ]))));
  }
}
