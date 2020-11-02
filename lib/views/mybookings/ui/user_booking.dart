import 'package:flutter/material.dart';
import 'package:shoptoken/views/category/ui/category_screen.dart';

import 'mybookinglist.dart';

class UserBooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyBookingList(),
      ),
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
