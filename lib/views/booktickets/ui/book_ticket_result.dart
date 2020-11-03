import 'package:flutter/material.dart';
import 'package:shoptoken/models/getallslots.dart';

class BookTicketResult extends StatefulWidget {
  final List<SlotData> slotsList;
  final Function(String, String, bool) callback;
  const BookTicketResult(
      {Key key, @required this.slotsList, @required this.callback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new BookTicketResultState();
}

class BookTicketResultState extends State<BookTicketResult> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2,
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0),
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
  final Function(String, String, bool) callback;

  final SlotData slots;
  const _BookTicketResultItem({Key key, this.slots, @required this.callback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookTicketResultItemState();
}

class _BookTicketResultItemState extends State<_BookTicketResultItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return widget.slots != null
        ? _getTimeSlotLayout(context)
        : Text('No Time available');
  }

  Container _getTimeSlotLayout(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.lightBlue, width: 2)),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              // Max Size
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.alarm),
                    Flexible(
                      child: Text(
                        "${widget.slots.startTime} to ${widget.slots.endTime}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              widget.slots.isSelect
                  ? Container(
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                            ),
                          )),
                    )
                  : Container(
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Icon(
                              Icons.radio_button_unchecked,
                              color: Colors.blue,
                            ),
                          ))),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            isSelected = !widget.slots.isSelect;
            // isSelected(isSelected);
            widget.slots.isSelect = isSelected;
          });
          widget.callback(
              widget.slots.startTime, widget.slots.endTime, isSelected);
        },
      ),
    );
  }
}
