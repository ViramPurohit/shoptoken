import 'package:Retailer/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

displayInputDialog(
    {BuildContext context, String text, VoidCallback onPressed}) async {
  String confirmCode = "";
  GlobalKey<FormState> _formKey = new GlobalKey();
  bool _validate = false;
  String _validateCode(String value) {
    if (value.length == 0) {
      return "Enter Code";
    }
    return null;
  }

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text,
                textAlign: TextAlign.center,
                style: getTextStyle().copyWith(fontWeight: FontWeight.bold)),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              autovalidate: _validate,
              child: TextFormField(
                obscureText: false,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 4,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                  labelText: "Enter Code",
                  counterText: "",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                validator: _validateCode,
                onSaved: (String val) {
                  print('Result----val $val');
                  confirmCode = val;
                },
              ),
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('SUBMIT'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  // No any error in validation
                  _formKey.currentState.save();

                  print('Result----confirmCode $confirmCode');
                  Navigator.pop(context, confirmCode);
                }
              },
            )
          ],
        );
      });
}
