import 'package:flutter/material.dart';
import 'package:shoptoken/models/getfavoriteresponse.dart';
import 'package:shoptoken/widgets/button.dart';
import 'package:shoptoken/widgets/text_style.dart';

class MyFavouriteListResult extends StatelessWidget {
  final Function(int) callback;
  final List<FavoriteData> favList;

  const MyFavouriteListResult(
      {Key key, @required this.favList, @required this.callback})
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
            callback: callback,
          );
        });
  }
}

class _FavResultItem extends StatefulWidget {
  final Function(int) callback;
  final FavoriteData favoriteData;

  const _FavResultItem({Key key, this.favoriteData, this.callback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavResultItemState();
}

class _FavResultItemState extends State<_FavResultItem> {
  @override
  Widget build(BuildContext context) {
    return widget.favoriteData != null
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
                child: Container(
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
                                      child: new Text(
                                          widget.favoriteData.shopName,
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
                                        child: new Icon(Icons.pin_drop)),
                                    Flexible(
                                      child: new Text(
                                          widget.favoriteData.address,
                                          textAlign: TextAlign.start,
                                          style: getTextStyle()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Container(
                            //     child: Padding(
                            //       padding: const EdgeInsets.only(top: 10.0),
                            //       child: Row(
                            //         children: [
                            //           Flexible(
                            //             child: Container(
                            //                 margin: const EdgeInsets.only(
                            //                     right: 10.0),
                            //                 child: new Icon(Icons.watch_later)),
                            //           ),
                            //           Flexible(
                            //             child: new Text(
                            //               favoriteData.isBooked,
                            //               style: getTextStyle().copyWith(
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // )
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
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: getBaseButton(
                                onPressed: () {
                                  callback:
                                  widget
                                      .callback(widget.favoriteData.retailerId);
                                },
                                text: 'Book'),
                          )
                        ])))
          ]),
        ),
      ),
    );
  }
}
