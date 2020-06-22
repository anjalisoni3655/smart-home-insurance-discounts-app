import 'package:flutter/material.dart';

Divider CustomDivider({double height = 0, double width = 0}) {
  return Divider(
    color: Colors.brown,
    height: height,
    thickness: height,
    indent: width,
    endIndent: width,
  );
}

SizedBox CustomSizedBox({double height = 0, double width = 0}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

TextStyle CustomTextStyle(
    {Color color = Colors.black87,
    double fontSize: 15.0,
    FontWeight fontWeight: FontWeight.bold,
    String fontFamily: "Open Sans Pro"}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: fontFamily,
  );
}

RaisedButton CustomRaisedButton(String route, String text, BuildContext context,
    double screenheight, double screenwidth) {
  return RaisedButton(
    onPressed: () {
      Navigator.of(context).pushNamed(route);
    },
    color: Colors.orange[50],
    elevation: 10.0,
    padding: const EdgeInsets.all(0.0),
    shape:
        RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
    child: Container(
      height: screenheight / 20,
      width: 13 * screenwidth / 20,
      padding: const EdgeInsets.all(10.0),
      child: Text(text,
          textAlign: TextAlign.center,
          style: CustomTextStyle(
            fontSize: 20.0,
          )),
    ),
  );
}
