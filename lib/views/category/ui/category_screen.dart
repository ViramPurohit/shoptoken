import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/views/category/bloc/category_bloc.dart';
import 'package:Retailer/views/category/bloc/category_event.dart';
import 'package:Retailer/views/category/ui/search_near_store.dart';

import 'category_list_screen.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen();

  @override
  State<StatefulWidget> createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  CategoryBloc _categoryBloc;

  @override
  void initState() {
    super.initState();
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _categoryBloc.add(FetchCategoryList());
  }

  @override
  Widget build(BuildContext context) {
    // _categoryBloc.add(event)
    return Scaffold(
      appBar: AppBar(
        title: Text('Select store type'),
      ),
      body: Column(
        children: <Widget>[CategoryList(), SearchNearStore()],
      ),
    );
  }
}
