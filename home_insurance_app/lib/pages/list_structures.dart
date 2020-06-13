import 'package:flutter/material.dart';

class ListStructures extends StatefulWidget {
  final List structures;
  const ListStructures(this.structures);
  @override
  _ListStructuresState createState() => _ListStructuresState();
}

class _ListStructuresState extends State<ListStructures> {
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    // data stores the list of structures owned by the user as a key-value pair.
    Map data = ModalRoute.of(context).settings.arguments;

    return AlertDialog(
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    // Displays the heading
                    'Choose Structure',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                //The column display the customNames of all the structures
                Column(
                  children: widget.structures
                      .map((structure) => ListTile(
                            title: Text('${structure['customName']}'),
                          ))
                      .toList(),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        Navigator.pop(context,
                            {"id": "12345", "customName": "Onyx Home"});
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
