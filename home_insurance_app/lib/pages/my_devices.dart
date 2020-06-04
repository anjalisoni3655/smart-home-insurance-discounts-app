import 'package:flutter/material.dart';
import 'package:homeinsuranceapp/main.dart';

List<ItemVO> mainList = List();
List<ItemVO> thermostats = [
  ItemVO("1", "nest hub"),
  ItemVO("2", "nest mini"),
  ItemVO("3", "chromecast")
];
List<ItemVO> camera = [
  ItemVO("1", "smoke alarm"),
  ItemVO("2", "nest cam"),
  ItemVO("3", "home mini")
];
List<ItemVO> smokeDetector = [
  ItemVO("1", "home max"),
  ItemVO("2", "home duo"),
  ItemVO("3", "thermostat")
];

List<ItemVO> home = [
  ItemVO("1", "a"),
  ItemVO("2", "b"),
  ItemVO("3", "c"),
];

class MyDevices extends StatefulWidget {
  static const String id = 'my_devices';
  @override
  State<StatefulWidget> createState() {
    return _MyDevicesState();
  }
}

class _MyDevicesState extends State<MyDevices> {
//  @override
// void initState() {
//    super.initState();
//    mainList.addAll(home);
//  }

  @override
  Widget build(BuildContext context) {
    theme:
    ThemeData.dark();

    return Material(
      child: Stack(
        children: <Widget>[
          ListView.builder(
            itemBuilder: (BuildContext context, index) {
              return getCard(index);
            },
            itemCount: mainList.length,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    mainList.clear();
                    setState(() {
                      mainList.addAll(thermostats);
                    });
                  },
                  heroTag: "btn1",
                  child: new Icon(Icons.devices_other),
                  backgroundColor: new Color(0xFFE57373),
                ),
                FloatingActionButton(
                  onPressed: () {
                    mainList.clear();
                    setState(() {
                      mainList.addAll(camera);
                    });
                  },
                  heroTag: "btn2",
                  child: new Icon(Icons.camera_alt),
                  backgroundColor: new Color(0xFFE57373),
                ),
                FloatingActionButton(
                  onPressed: () {
                    mainList.clear();
                    setState(() {
                      mainList.addAll(smokeDetector);
                    });
                  },
                  heroTag: "btn3",
                  child: new Icon(Icons.smoke_free),
                  backgroundColor: new Color(0xFFE57373),
                ),
                FloatingActionButton(
                  onPressed: () {
                    mainList.clear();
                    setState(() {
                      mainList.addAll(home);
                    });
                  },
                  heroTag: "btn4",
                  child: new Icon(Icons.home),
                  backgroundColor: new Color(0xFFE57373),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*
    Get the card item for a list
   */
  getCard(int position) {
    ItemVO model = mainList[position];
    return Card(
      child: Container(
        color: Colors.lightBlueAccent,
        //child: Text("Flutter CheatSheet."),
        height: 50,
        alignment: Alignment.center,
        child: Row(
          //Text("Flutter CheatSheet."),
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            Text(
//              "ID:: "+model._id,
//              style: TextStyle(fontSize: 18, color: Colors.black),
//            ),
            Padding(padding: EdgeInsets.only(left: 5, right: 5)),
            Text(
              " " + model._name,
              style: TextStyle(fontSize: 18, color: Colors.black),
            )
          ],
        ),
      ),
      margin: EdgeInsets.all(10),
    );
  }
}

/*
Custom model
i.e. for itemList
 */
class ItemVO {
  String _id, _name;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  ItemVO(this._id, this._name);
}
