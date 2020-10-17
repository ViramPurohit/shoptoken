import 'package:Retailer/models/retailerallbookings.dart';
import 'package:Retailer/widgets/button.dart';
import 'package:Retailer/widgets/text_style.dart';
import 'package:flutter/material.dart';

class CustomerListResult extends StatefulWidget {
  final Function(int) callback;

  CustomerListResult(
      {Key key, @required this.bookingList, @required this.callback})
      : super(key: key);
  final List<RetailerbookinData> bookingList;
  @override
  _CustomerListResultState createState() => new _CustomerListResultState();
}

class _CustomerListResultState extends State<CustomerListResult> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.bookingList.length,
        itemBuilder: (BuildContext context, int index) {
          return _BookResultItem(
            slots: widget.bookingList[index],
            callback: widget.callback,
          );
        });
  }
}

class _BookResultItem extends StatelessWidget {
  final RetailerbookinData slots;
  final Function(int) callback;

  const _BookResultItem({Key key, this.slots, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return slots != null
        ? _getTimeSlotLayout(context)
        : Text('No Time available');
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
                    height: 180.0,
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
                                    new Text(slots.fullName,
                                        textAlign: TextAlign.start,
                                        style: getTextStyle().copyWith(
                                            fontWeight: FontWeight.bold)),
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
                                    new Text(slots.mobileNo,
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
                                            child: new Icon(Icons.phone)),
                                      ),
                                      Flexible(
                                        child: new Text(
                                          'Time slot ${slots.bookStartTime} To ${slots.bookEndTime}',
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
                    height: 160.0,
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
                                  // Container(
                                  //     margin:
                                  //         const EdgeInsets.only(right: 10.0),
                                  //     child: new Icon(
                                  //         Icons.supervised_user_circle)),

                                  new Text(slots.ticketNumber.toString(),
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
                                child: getColorButton(
                                  text: 'Enter Code',
                                  colors: Color(0xFF1B5E20),
                                  onPressed: () {
                                    print("slots.bookI ${slots.bookId}");
                                    callback(slots.bookId);
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
