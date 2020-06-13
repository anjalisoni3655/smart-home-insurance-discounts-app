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
