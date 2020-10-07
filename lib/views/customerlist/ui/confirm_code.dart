import 'package:flutter/material.dart';
import 'package:Retailer/views/home/ui/home_screen.dart';
import 'package:Retailer/widgets/text_style.dart';

class ConfirmCodeScreen extends StatelessWidget {
  static const String routeName = '/BookConfirmScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ticket Booked'),
        ),
        drawer: HomeScreen(),
        body: Container(
            margin: const EdgeInsets.all(10.0),
            child: Center(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(
                      'Your ticket is booked for 10am to 5pm on 23/04/2020',
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
                    child: new Text(
                      'Confirmation code on SMS',
                      style:
                          getTextStyle().copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(
                      '0202',
                      style: getTextStyle()
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ]))));
  }
}
