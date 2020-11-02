import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/models/categories.dart';
import 'package:shoptoken/models/nearshop.dart';
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
          return state.result.nearshopresult.isError == 0
              ? Expanded(
                  child: _NearestStoreResults(
                    nearshopList: state.result.nearshopresult.data,
                  ),
                )
              : Text('No shop added with your area...');
        } else {
          return Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}

class _NearestStoreResults extends StatefulWidget {
  final List<NearshopData> nearshopList;

  const _NearestStoreResults({Key key, @required this.nearshopList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _NearestStoreState();
  }
}

class _NearestStoreState extends State<_NearestStoreResults> {
  List<NearshopData> shopList;

  @override
  void initState() {
    super.initState();
    shopList = new List<NearshopData>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 3),
          ),
          itemCount: widget.nearshopList.length,
          itemBuilder: (BuildContext context, int index) {
            return GridItem(
                nearShop: widget.nearshopList[index],
                isBooked: (bool value) {
                  setState(() {
                    if (value) {
                      shopList.add(widget.nearshopList[index]);
                    } else {
                      shopList.remove(widget.nearshopList[index]);
                    }
                  });
                },
                key: Key(widget.nearshopList[index].id.toString()));
          }),
    );
  }
}

class GridItem extends StatefulWidget {
  final NearshopData nearShop;
  final Key key;
  final ValueChanged<bool> isBooked;

  const GridItem({this.key, this.nearShop, this.isBooked});

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
    return widget.nearShop.shopName != null
        ? _getCategotyLayout()
        : Center(child: Text('No Store available'));
  }

  ImageProvider getImage() {
    if (widget.nearShop.url == null) {
      return new NetworkImage(widget.nearShop.url);
    } else {
      return new NetworkImage(widget.nearShop.url);
    }
  }

  void navigateToDatePicker() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookTicketScreen(
                  retailerid: widget.nearShop.id,
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
            Flexible(
              child: Card(
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
                                    child: new Text(widget.nearShop.shopName,
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
                                      child:
                                          new Text(widget.nearShop.address))),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: new Text(
                                        'Open from ${widget.nearShop.startAt} To ${widget.nearShop.endAt}',
                                        style: getTextStyle().copyWith(
                                            fontWeight: FontWeight.bold),
                                      ))),
                            )
                          ],
                        ))),
              ),
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
                          text: 'Book',
                          colors:
                              isBooked ? Color(0xFF1B5E20) : Color(0xff01A0C7),
                          onPressed: () {
                            setState(() {
                              // isBooked = !isBooked;
                              // widget.isBooked(isBooked);
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
