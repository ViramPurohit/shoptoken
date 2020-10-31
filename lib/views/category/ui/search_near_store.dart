import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/models/categories.dart';
import 'package:shoptoken/utils/dialog.dart';
import 'package:shoptoken/views/category/bloc/category_bloc.dart';
import 'package:shoptoken/views/category/bloc/category_state.dart';
import 'package:shoptoken/views/stores/ui/storelist.dart';
import 'package:shoptoken/widgets/button.dart';

class SearchNearStore extends StatefulWidget {
  SearchNearStore({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchNearStoreState();
  }
}

class SearchNearStoreState extends State<SearchNearStore> {
  List<SearchNearStore> categoryDataList;
  String ids;
  @override
  void initState() {
    super.initState();
    ids = "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (BuildContext context, CategoryState state) {
        print("CategoryState============$state");
        if (state is CategorySelectSuccess) {
          ids = state.categoryIds;
          print("CategorySelectSuccess============$ids");
        }
      },
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (BuildContext context, CategoryState state) {
          return Container(
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        getRectangleButton(
                            text: 'Search near by',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          StoresScreen(ids: ids)));
                            })
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
