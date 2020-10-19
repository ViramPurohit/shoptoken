import 'package:Retailer/views/setting/ui/settling_option_screen.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  //requiring the list of todos
  SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => new _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Container(
          child: SingleChildScrollView(
              child: Container(
                  child: Column(
        children: <Widget>[SettingOptions()],
      )))),
    );
  }
}
