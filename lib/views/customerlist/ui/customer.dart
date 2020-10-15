import 'package:flutter/material.dart';

import 'customerlist.dart';

class CustomerScreen extends StatefulWidget {
  CustomerScreen({Key key}) : super(key: key);

  @override
  _CustomerScreenState createState() => new _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SingleChildScrollView(
              child: Container(
                  child: Column(
        children: <Widget>[CustomerList()],
      )))),
    );
  }
}
