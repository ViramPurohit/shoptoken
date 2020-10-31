import 'package:flutter/material.dart';
import 'package:shoptoken/models/customerbookingresponse.dart';
import 'package:shoptoken/models/getfavoriteresponse.dart';

import 'package:shoptoken/widgets/button.dart';
import 'package:shoptoken/widgets/text_style.dart';

class MyFavouriteListResult extends StatelessWidget {
  final List<FavoriteData> favList;

  const MyFavouriteListResult({Key key, @required this.favList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: favList.length,
        itemBuilder: (BuildContext context, int index) {
          return _FavResultItem(
            favoriteData: favList[index],
          );
        });
  }
}

class _FavResultItem extends StatelessWidget {
  final FavoriteData favoriteData;

  const _FavResultItem({Key key, this.favoriteData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return favoriteData != null
        ? _getTimeSlotLayout(context)
        : Text('No Favourite Shop yet!');
  }

  Container _getTimeSlotLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 2,
        child: Center(
          child: new Row(children: <Widget>[
            Container(
              child: Flexible(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                        child: new Icon(
                                            Icons.supervised_user_circle)),
                                    Flexible(
                                      child: new Text(favoriteData.shopName,
                                          textAlign: TextAlign.start,
                                          style: getTextStyle().copyWith(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                        child: new Icon(Icons.phone)),
                                    new Text(favoriteData.address,
                                        textAlign: TextAlign.start,
                                        style: getTextStyle().copyWith(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 10.0),
                                            child: new Icon(Icons.watch_later)),
                                      ),
                                      Flexible(
                                        child: new Text(
                                          favoriteData.isBooked,
                                          style: getTextStyle().copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))),
              ),
            ),
            Flexible(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("Ticket Number",
                              textAlign: TextAlign.start,
                              style: getTextStyle()
                                  .copyWith(fontWeight: FontWeight.bold)),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new Text("bookings.ticketNumber.toString()",
                                      textScaleFactor: 1.8,
                                      textAlign: TextAlign.start,
                                      style: getTextStyle().copyWith(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ])))
          ]),
        ),
      ),
    );
  }
}
