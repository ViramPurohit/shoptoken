import 'package:flutter/material.dart';

import 'myfavouritelist.dart';

class MyFavourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite stores'),
      ),
      body: Container(
          child: SingleChildScrollView(
              child: Container(
                  child: Column(
        children: <Widget>[MyFavouriteList()],
      )))),
    );
  }
}
