import 'package:Retailer/views/storetime/ui/define_time_slot_screen.dart';
import 'package:Retailer/views/storetime/ui/select_store_time_screen.dart';
import 'package:flutter/material.dart';

class StoreTimeScreen extends StatefulWidget {
  //requiring the list of todos
  StoreTimeScreen({Key key}) : super(key: key);

  @override
  _BookTicketScreenState createState() => new _BookTicketScreenState();
}

class _BookTicketScreenState extends State<StoreTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Store time'),
      ),
      body: Container(
          child: SingleChildScrollView(
              child: Container(
                  child: Column(
        children: <Widget>[
          SelectStoreSrtEndTime(),
          SelectUserSlotScreen(),
        ],
      )))),
    );
  }
}
