import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/pages/style/custom_widgets.dart';

// Map eah structure with a unique index for selecting Radio Buttons
class Mapping {
  Map structure;
  int index;
  Mapping(int index, Map structure) {
    this.index = index;
    this.structure = structure;
  }
}

// Structure selected by the user
Map userChoice = {};

//Class defining overall  layout of the alert dialogue box
class StructureAlertBox extends StatefulWidget {
  final List structures;
  const StructureAlertBox(this.structures);
  @override
  _StructureAlertBoxState createState() => _StructureAlertBoxState();
}

class _StructureAlertBoxState extends State<StructureAlertBox> {
  @override
  Widget build(BuildContext context) {
    // data stores the list of structures owned by the user as a key-value pair.
    Map data = ModalRoute.of(context).settings.arguments;

    return AlertDialog(
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Text(
                    'Choose Structure',
                    style: CustomTextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                ShowStructures(widget.structures),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton.extended(
                      label: Text('Submit'),
                      onPressed: () {
                        Navigator.pop(context, userChoice);
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

// This class is used to display a list of structures in dialogue box  preceded by the radio buttons
class ShowStructures extends StatefulWidget {
  final List structures;
  const ShowStructures(this.structures);

  @override
  _ShowStructuresState createState() => _ShowStructuresState();
}

class _ShowStructuresState extends State<ShowStructures> {
  int choosenIndex =
      0; // Stores the index corresponding to the selected structure

  List<Mapping> choices = new List<Mapping>();
  @override
  void initState() {
    super.initState();
    userChoice = widget.structures[
        0]; // By default the first structure will be displayed as selected  .
    for (int i = 0; i < widget.structures.length; i++) {
      choices.add(new Mapping(i, widget.structures[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      // Wraping ListView inside Container to assign scrollable screen a height and width
      width: screenWidth / 2,
      height: screenHeight / 3,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: choices
            .map((entry) => RadioListTile(
                  key: Key('Structure ${entry.index}'),
                  title: Text('${entry.structure['customName']}'),
                  groupValue: choosenIndex,
                  activeColor: Colors.blue[500],
                  value: entry.index,
                  onChanged: (value) {
                    // A radio button gets selected only when groupValue is equal to value of the respective radio button
                    setState(() {
                      userChoice = entry.structure;
                      //To make groupValue equal to value for the radio button .
                      choosenIndex = value;
                    });
                  },
                ))
            .toList(),
      ),
    );
  }
}
