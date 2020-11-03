import 'package:flutter/material.dart';
import 'package:shoptoken/views/category/ui/category_screen.dart';

import 'mybookinglist.dart';

class UserBooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SingleChildScrollView(
              child: Container(
                  child: Column(
        children: <Widget>[MyBookingList()],
      )))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CategoryScreen()));
        },
        label: Text('New Booking'),
        icon: Icon(Icons.shopping_cart),
        backgroundColor: Colors.green,
      ),
    );
  }
}
