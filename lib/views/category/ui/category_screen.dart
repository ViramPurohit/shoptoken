import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/views/category/bloc/category_bloc.dart';
import 'package:Retailer/views/category/bloc/category_event.dart';
import 'package:Retailer/views/category/ui/submit_category.dart';

import 'category_list_screen.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen();

  @override
  State<StatefulWidget> createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    // _categoryBloc.add(event)
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: Column(
        children: <Widget>[CategoryList()],
      ),
    );
  }
}
