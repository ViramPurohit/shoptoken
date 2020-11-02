import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoptoken/views/stores/bloc/neareststore_bloc.dart';
import 'package:shoptoken/views/stores/bloc/neareststore_event.dart';

import 'package:shoptoken/views/stores/ui/store_list_screen.dart';

class StoresScreen extends StatefulWidget {
  StoresScreen({@required this.ids});
  final String ids;
  @override
  State<StatefulWidget> createState() => StoresScreenState();
}

class StoresScreenState extends State<StoresScreen> {
  NearestStoreBloc _categoryBloc;

  @override
  void initState() {
    super.initState();
    _categoryBloc = BlocProvider.of<NearestStoreBloc>(context);
    getNearestStore();
  }

  Future<void> getNearestStore() async {
    var requestMap = new Map<String, dynamic>();
    requestMap['lat'] = "0.0";
    requestMap['lng'] = "0.0";
    requestMap['category_ids'] = widget.ids;

    print("requestMap $requestMap");
    _categoryBloc.add(FetchNearestStoreEventList(requestMap: requestMap));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Nearest Stores'),
      ),
      body: Column(
        children: <Widget>[StoreList()],
      ),
    );
  }
}
