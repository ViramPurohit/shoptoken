import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/models/categories.dart';
import 'package:shoptoken/views/booktickets/ui/book_ticket_screen.dart';
import 'package:shoptoken/views/stores/bloc/neareststore_bloc.dart';
import 'package:shoptoken/views/stores/bloc/neareststore_state.dart';

import 'package:shoptoken/widgets/button.dart';
import 'package:shoptoken/widgets/text_style.dart';

class StoreList extends StatelessWidget {
  StoreList();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearestStoreBloc, NearestStoreState>(
      // bloc: BlocProvider.of<NearestStoreBloc>(context),
      builder: (BuildContext context, NearestStoreState state) {
        if (state is NearestStoreFailure) {
          return Text(state.error);
        }
        if (state is NearestStoreSuccess) {
          return state.result.data.isEmpty
              ? Text('No shop added with your area...')
              : Expanded(
                  child: _SongsSearchResults(
                    categoryList: state.result.data,
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

class _SongsSearchResults extends StatefulWidget {
  final List<CategoryData> categoryList;

  const _SongsSearchResults({Key key, @required this.categoryList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new __SongsSearchState();
  }
}

class __SongsSearchState extends State<_SongsSearchResults> {
  List<CategoryData> bookedList;

  @override
  void initState() {
    super.initState();
    bookedList = new List<CategoryData>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 4),
          ),
          itemCount: widget.categoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return GridItem(
                category: widget.categoryList[index],
                isBooked: (bool value) {
                  setState(() {
                    if (value) {
                      bookedList.add(widget.categoryList[index]);
                    } else {
                      bookedList.remove(widget.categoryList[index]);
                    }
                  });
                },
                key: Key(widget.categoryList[index].email.toString()));
          }),
    );
  }
}

class GridItem extends StatefulWidget {
  final CategoryData category;
  final Key key;
  final ValueChanged<bool> isBooked;

  const GridItem({this.key, this.category, this.isBooked});

  @override
  State<StatefulWidget> createState() {
    return new _GridItemState();
  }
}

class _GridItemState extends State<GridItem> {
  bool isBooked = false;

  @override
  Widget build(BuildContext context) {
    print("On pageview firstName --  $widget.category.firstName");
    return widget.category.firstName != null
        ? _getCategotyLayout()
        : Center(child: Text('No Store available'));
  }

  ImageProvider getImage() {
    if (widget.category.avatar == null) {
      return new NetworkImage(widget.category.avatar);
    } else {
      return new NetworkImage(widget.category.avatar);
    }
  }

  void navigateToDatePicker() {
    var shopid = 101;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookTicketScreen(
                  shopid: shopid,
                )));
  }

  Container _getCategotyLayout() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: new InkWell(
          highlightColor: Colors.blue.withAlpha(30),
          splashColor: Colors.white.withAlpha(20),
          child: new Row(children: <Widget>[
            Card(
              elevation: 2.0,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 200.0,
                  child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: new Text(
                                      'Purohit General store Purohit General',
                                      textAlign: TextAlign.start,
                                      style: getTextStyle().copyWith(
                                          fontWeight: FontWeight.bold)),
                                )),
                          ),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: new Text('Odhav,Ahmedabad'))),
                          ),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: new Text(
                                      'Open from 10am to 5pm',
                                      style: getTextStyle().copyWith(
                                          fontWeight: FontWeight.bold),
                                    ))),
                          )
                        ],
                      ))),
            ),
            Card(
              elevation: 2.0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.41,
                height: 200.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: new Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Image(
                            image: getImage(),
                          )),
                    ),
                    Padding(
                        padding: EdgeInsets.all(4.0),
                        child: getColorButton(
                          text: isBooked ? 'Booked' : 'Book',
                          colors:
                              isBooked ? Color(0xFF1B5E20) : Color(0xff01A0C7),
                          onPressed: () {
                            setState(() {
                              isBooked = !isBooked;
                              widget.isBooked(isBooked);
                              navigateToDatePicker();
                            });
                          },
                        ))
                  ],
                ),
              ),
            ),
          ]),
          onTap: () {},
        ),
      ),
    );
  }
}
