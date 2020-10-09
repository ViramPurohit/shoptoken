import 'package:Retailer/utils/apppreferences.dart';
import 'package:Retailer/utils/dialog.dart';
import 'package:Retailer/views/category/bloc/category_event.dart';
import 'package:Retailer/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/models/categories.dart';
import 'package:Retailer/views/category/bloc/category_bloc.dart';
import 'package:Retailer/views/category/bloc/category_state.dart';

class CategoryList extends StatefulWidget {
  CategoryList({Key key, this.firstName}) : super(key: key);

  final String firstName;

  @override
  State<StatefulWidget> createState() => CategoryListState();
}

class CategoryListState extends State<CategoryList> {
  List<CategoryData> categoryList;
  List<CategoryData> selectedcategory;
  CategoryBloc _categoryBloc;

  @override
  void initState() {
    super.initState();
    categoryList = new List<CategoryData>();
    selectedcategory = new List<CategoryData>();
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _categoryBloc.add(FetchCategoryList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (BuildContext context, CategoryState state) {
        if (state is CategorySuccess) {
          print(state.result);
          Dialogs().dismissLoaderDialog(context);
          categoryList = state.result.categorylistresult.data;
        }

        if (state is CategorySubmitSuccess) {}
      },
      child: BlocBuilder<CategoryBloc, CategoryState>(
        // bloc: BlocProvider.of<BookTicketBloc>(context),
        builder: (BuildContext context, CategoryState state) {
          if (state is CategoryFailure) {
            return SnackBar(
              content: Text(state.error),
              backgroundColor: Theme.of(context).errorColor,
            );
          }
          if (state is CategoryInProgress) {
            Dialogs().showLoaderDialog(context);
          }

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
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                child: categoryList.isEmpty
                                    ? Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text('Collecting Category'))
                                    : _CategoryResults(
                                        categoryList: categoryList,
                                        callback: callback,
                                      )),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              child: getBaseButton(
                                  onPressed: () {
                                    if (categoryList.isNotEmpty) {
                                      submitCategory(categoryList);
                                    }
                                  },
                                  text: 'Submit'),
                            ),
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

  callback(selectedList) {
    setState(() {
      selectedcategory = selectedList;
      print('Booking date ${selectedcategory.length}');
    });
  }

  Future<void> submitCategory(List<CategoryData> selectedList) async {
    var categoryIds = new List();

    for (var category in selectedList) {
      categoryIds.add(category.id);
    }
    var requestMap = new Map<String, dynamic>();
    requestMap['retailer_id'] = await Apppreferences().getUserId();
    requestMap['category_id'] = categoryIds.toString();

    _categoryBloc.add(SubmitCategoryEvent(requestMap: requestMap));
  }
}

class _CategoryResults extends StatefulWidget {
  final List<CategoryData> categoryList;
  final Function(List<CategoryData>) callback;

  const _CategoryResults(
      {Key key, @required this.categoryList, @required this.callback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _CategoryResultsState();
  }
}

class _CategoryResultsState extends State<_CategoryResults> {
  List<CategoryData> selectedList;

  @override
  void initState() {
    super.initState();
    selectedList = new List<CategoryData>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? 2
                      : 3),
          itemCount: widget.categoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return GridItem(
                category: widget.categoryList[index],
                isSelected: (bool value) {
                  setState(() {
                    if (value) {
                      selectedList.add(widget.categoryList[index]);
                    } else {
                      selectedList.remove(widget.categoryList[index]);
                    }
                    // _categoryBloc
                    //     .add(CategoryItemSelect(selectedList: selectedList));
                    widget.callback(selectedList);
                  });
                  print("index $index : on Click isSelected $value");
                },
                key: Key(widget.categoryList[index].englishName.toString()));
          }),
    );
  }
}

class GridItem extends StatefulWidget {
  final CategoryData category;
  final Key key;
  final ValueChanged<bool> isSelected;

  const GridItem({this.key, this.category, this.isSelected});

  @override
  State<StatefulWidget> createState() {
    return new _GridItemState();
  }
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return widget.category.englishName != null
        ? _getCategotyLayout()
        : Center(child: Text('Coming soon...'));
  }

  ImageProvider getImage() {
    if (widget.category.url == null) {
      return new NetworkImage(widget.category.url);
    } else {
      return new NetworkImage(widget.category.url);
    }
  }

  Padding _getCategotyLayout() {
    print("On pageview isSelected --  $isSelected");
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Card(
          elevation: 2.0,
          child: Center(
            child: new InkWell(
              highlightColor: Colors.white.withAlpha(30),
              splashColor: Colors.white.withAlpha(20),
              child: new Column(children: <Widget>[
                Expanded(
                  child: new Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Image(image: getImage())),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(3.0),
                  child: new Text(
                    widget.category.englishName,
                    textAlign: TextAlign.left,
                  ),
                ),
                isSelected
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                          ),
                        ))
                    : Container()
              ]),
              onTap: () {
                setState(() {
                  isSelected = !isSelected;
                  widget.isSelected(isSelected);
                });
              },
            ),
          ),
        ));
  }
}
