import 'package:flutter/material.dart';
import 'package:Retailer/views/stores/ui/storelist.dart';
import 'package:Retailer/widgets/button.dart';

class SearchNearStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        getRectangleButton(
            text: 'Search near by',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StoresScreen()));
            })
      ],
    );
  }
}
