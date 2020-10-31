import 'package:flutter/material.dart';
import 'package:shoptoken/models/customerbookingresponse.dart';
import 'package:shoptoken/models/getallslots.dart';
import 'package:shoptoken/widgets/button.dart';
import 'package:shoptoken/widgets/text_style.dart';

class MyBookingListResult extends StatelessWidget {
  final Function(int) callback;
  final List<CustomerbookingData> bookingList;

  const MyBookingListResult(
      {Key key, @required this.bookingList, @required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: bookingList.length,
        itemBuilder: (BuildContext context, int index) {
          return _BookTicketResultItem(
            bookings: bookingList[index],
            callback: callback,
          );
        });
  }
}

class _BookTicketResultItem extends StatelessWidget {
  final CustomerbookingData bookings;

  final Function(int) callback;

  const _BookTicketResultItem({Key key, this.bookings, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bookings != null
        ? _getTimeSlotLayout(context)
        : Text('No Slot available');
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
                                      child: new Text(bookings.fullName,
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
                                    new Text(bookings.mobileNo,
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
                                          'Time slot ${bookings.bookStartTime} To ${bookings.bookEndTime}',
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
                                  new Text(bookings.ticketNumber.toString(),
                                      textScaleFactor: 1.8,
                                      textAlign: TextAlign.start,
                                      style: getTextStyle().copyWith(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: getFavButton(
                                  text: 'Add to Favourite',
                                  colors: Colors.green[800],
                                  onPressed: () {
                                    print(
                                        "slots.retailerId ${bookings.retailerId}");
                                    callback(bookings.retailerId);
                                  },
                                )),
                          ),
                        ])))
          ]),
        ),
      ),
    );
  }
}
