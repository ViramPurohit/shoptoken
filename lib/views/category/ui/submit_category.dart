import 'package:Retailer/models/categories.dart';
import 'package:Retailer/utils/apppreferences.dart';
import 'package:Retailer/views/category/bloc/category_bloc.dart';
import 'package:Retailer/views/category/bloc/category_event.dart';
import 'package:Retailer/views/category/bloc/category_state.dart';
import 'package:Retailer/views/category/ui/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:Retailer/views/stores/ui/storelist.dart';
import 'package:Retailer/widgets/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitStoreCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SubmitStoreState();
}

class SubmitStoreState extends State<SubmitStoreCategory> {
  CategoryBloc _categoryBloc;
  List<CategoryData> selectedList;

  @override
  void initState() {
    super.initState();
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    selectedList = new List<CategoryData>();
  }

  Future<void> submitCategory() async {
    var categoryIds = new StringBuffer();
    for (var category in selectedList) {
      categoryIds.write(category.id);
      categoryIds.write(",");
    }
    print(categoryIds.toString());
    var finalIds =
        categoryIds.toString().substring(0, categoryIds.toString().length - 1);

    print(finalIds.toString());
    var requestMap = new Map<String, dynamic>();
    requestMap['retailer_id'] = await Apppreferences().getUserId();
    requestMap['category_id'] = finalIds.toString();

    _categoryBloc.add(SubmitCategoryEvent(requestMap: requestMap));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (BuildContext context, CategoryState state) {
        if (state is CategorySelectSuccess) {
          selectedList = state.result;
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
                    child: Card(
                      elevation: 2,
                      child: SingleChildScrollView(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(20.0),
                              child: getBaseButton(
                                  onPressed: () {}, text: 'Submit'),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
