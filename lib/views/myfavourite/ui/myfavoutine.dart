import 'package:flutter/material.dart';

import 'mybookinglist.dart';

class MyFavourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyFavouriteList(),
      ),
    );
  }
}
