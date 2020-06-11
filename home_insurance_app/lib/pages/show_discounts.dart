import 'package:flutter/material.dart';

class DisplayDiscounts extends StatefulWidget {
  @override
  DisplayDiscountsState createState() => DisplayDiscountsState();
}
//This class gives the overall layout for the show discounts page .
class DisplayDiscountsState extends State<DisplayDiscounts> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Available Discounts'));
  }
}
