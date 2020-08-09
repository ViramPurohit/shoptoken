import 'package:flutter/material.dart';
import 'package:shoptoken/widgets/text_style.dart';

Material getBaseButton({String text, VoidCallback onPressed}) {
  return Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(5.0),
    color: Color(0xff01A0C7),
    child: MaterialButton(
      minWidth: double.infinity,
      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
      onPressed: onPressed,
      child: Text(text,
          textAlign: TextAlign.center,
          style: getTextStyle()
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}

Material getColorButton({String text, Color colors, VoidCallback onPressed}) {
  return Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(5.0),
    color: colors,
    child: MaterialButton(
      minWidth: double.infinity,
      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
      onPressed: onPressed,
      child: Text(text,
          textAlign: TextAlign.center,
          style: getTextStyle()
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}

Material getRectangleButton({String text, VoidCallback onPressed}) {
  return Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(1.0),
    color: Color(0xff01A0C7),
    child: MaterialButton(
      minWidth: double.infinity,
      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
      onPressed: onPressed,
      child: Text(text,
          textAlign: TextAlign.center,
          style: getTextStyle()
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}
