import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/models/categories.dart';
import 'package:shoptoken/utils/dialog.dart';
import 'package:shoptoken/utils/util_page.dart';
import 'package:shoptoken/views/category/bloc/category_bloc.dart';
import 'package:shoptoken/views/category/bloc/category_event.dart';
import 'package:shoptoken/views/category/bloc/category_state.dart';

class CategoryList extends StatefulWidget {
  CategoryList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CategoryListState();
  }
}

CategoryBloc _categoryBloc;

class CategoryListState extends State<CategoryList> {
  List<CategoryData> categoryDataList;

  @override
  void initState() {
    super.initState();
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    categoryDataList = new List<CategoryData>();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<State> _keyLoader = new GlobalKey<State>();

    return BlocListener<CategoryBloc, CategoryState>(
      listener: (BuildContext context, CategoryState state) {
        if (state is CategoryInProgress) {
          Dialogs().showLoadingDialog(context, _keyLoader);
        }
        if (state is CategoryFailure) {
          Dialogs().dismissLoadingDialog(_keyLoader.currentContext);
          Util().showErrorToast(context, state.error);
        }

        if (state is CategorySuccess) {
          print("CategorySuccess============");
          Dialogs().dismissLoadingDialog(_keyLoader.currentContext);
          categoryDataList = state.result.categorylistresult.data;
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
                    child: SingleChildScrollView(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: categoryDataList.isEmpty
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text('Fetching Category'))
                                  : _CategoryResults(
                                      categoryList: categoryDataList,
                                    )),
                        ],
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

class _CategoryResults extends StatefulWidget {
  final List<CategoryData> categoryList;

  const _CategoryResults({Key key, @required this.categoryList})
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
          scrollDirection: Axis.vertical,
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
                    collectIds(selectedList);
                  });
                },
                key: Key(widget.categoryList[index].englishName.toString()));
          }),
    );
  }
}

void collectIds(List<CategoryData> selectedList) {
  var categoryIds = new StringBuffer();

  for (var category in selectedList) {
    categoryIds.write(category.id);
    categoryIds.write(",");
  }

  var finalIds = "";
  if (categoryIds.isNotEmpty) {
    finalIds =
        categoryIds.toString().substring(0, categoryIds.toString().length - 1);
  }
  print("collectIds $finalIds");

  _categoryBloc.add(CategorySelectEvent(categoryIds: finalIds));
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
    if (widget.category.categoryurl == null) {
      return new NetworkImage(widget.category.categoryurl);
    } else {
      return new NetworkImage(widget.category.categoryurl);
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
