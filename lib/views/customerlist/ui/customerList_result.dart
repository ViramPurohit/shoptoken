import 'package:flutter/material.dart';
import 'package:shoptoken/models/getallslots.dart';

class CustomerListResult extends StatelessWidget {
  final List<BookSlots> slotsList;

  const CustomerListResult({Key key, @required this.slotsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: slotsList.length,
        itemBuilder: (BuildContext context, int index) {
          return _BookTicketResultItem(
            slots: slotsList[index],
          );
        });
  }
}

class _BookTicketResultItem extends StatelessWidget {
  final BookSlots slots;

  const _BookTicketResultItem({Key key, this.slots}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return slots.pantoneValue != null
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
          title: Text(slots.pantoneValue),
          onTap: () {},
        ));
  }
}
