import 'package:flutter/material.dart';
import 'package:shoptoken/models/getallslots.dart';

class BookTicketResult extends StatefulWidget {
  final List<SlotData> slotsList;
  final Function(String, String) callback;
  const BookTicketResult(
      {Key key, @required this.slotsList, @required this.callback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new BookTicketResultState();
}

class BookTicketResultState extends State<BookTicketResult> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.slotsList.length,
        itemBuilder: (BuildContext context, int index) {
          return _BookTicketResultItem(
            slots: widget.slotsList[index],
            callback: widget.callback,
          );
        });
  }
}

class _BookTicketResultItem extends StatefulWidget {
  final Function(String, String) callback;

  final SlotData slots;
  const _BookTicketResultItem({Key key, this.slots, @required this.callback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookTicketResultItemState();
}

class _BookTicketResultItemState extends State<_BookTicketResultItem> {
  @override
  Widget build(BuildContext context) {
    return widget.slots != null
        ? _getTimeSlotLayout(context)
        : Text('No Time available');
  }

  Container _getTimeSlotLayout(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlue, width: 2)),
        child: ListTile(
          leading: Icon(Icons.timer),
          title: Text("${widget.slots.startTime} to ${widget.slots.endTime}"),
          onTap: () {
            widget.callback(widget.slots.startTime, widget.slots.endTime);
          },
        ));
  }
}
