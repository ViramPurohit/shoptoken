import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/models/categories.dart';
import 'package:Retailer/views/category/bloc/category_bloc.dart';
import 'package:Retailer/views/category/bloc/category_state.dart';

class CategoryList extends StatelessWidget {
  CategoryList({Key key, this.firstName}) : super(key: key);

  final String firstName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      // bloc: BlocProvider.of<CategoryBloc>(context),
      builder: (BuildContext context, CategoryState state) {
        if (state is CategoryFailure) {
          return Text(state.error);
        }
        if (state is CategorySuccess) {
          return state.result.categorylistresult.data.isEmpty
              ? Text('Coming soon...')
              : Expanded(
                  child: _CategoryResults(
                    categoryList: state.result.categorylistresult.data,
                  ),
                );
        } else {
          return Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Center(child: CircularProgressIndicator()));
        }
      },
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
                // Container(
                //   alignment: Alignment.topCenter,
                //   padding: EdgeInsets.all(3.0),
                //   child: new Text(
                //       widget.category.firstName +
                //           ' ' +
                //           widget.category.lastName,
                //       textAlign: TextAlign.start),
                // ),
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
