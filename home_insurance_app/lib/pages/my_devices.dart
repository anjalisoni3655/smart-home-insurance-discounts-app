import 'package:flutter/material.dart';

//List of structures that would be derived from API call
List<String> structures = ["Home1", "Home2", "Home3"];
//List of devices present in  selected structure - derived from API call.
List<String> devices = [
  "ThermostatT1",
  "ThermostatT2",
  "DoorbellD1",
  "Smoke DetectorSD1",
  "Smoke DetectorSD2",
  "CameraC1",
  "CameraC2",
  "CameraC3",
];

class MyDevices extends StatefulWidget {
  @override
  _MyDevicesState createState() => _MyDevicesState();
}

class _MyDevicesState extends State<MyDevices> {
  // Data structures required to display which home is selected
  // Each home has a boolean value maintaining whether the home is selected or not
  List<bool> isSelected = List.filled(structures.length, false);
// Current home selected
  String home_selected = "Home1";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Insurance Company '),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'My Devices',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  fontFamily: "PTSerifBI",
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Divider(
              height: 10.0,
              color: Colors.blue[50],
              thickness: 10.0,
              indent: 10.0,
              endIndent: 10.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: structures.map((home) {
                return Column(
                  children: <Widget>[
                    OutlineButton(
                      onPressed: () {
                        // Change the current home selected
                        setState(() {
                          // unselect the previous home
                          isSelected[structures.indexOf(home_selected)] = false;
                          // change the home_selected to current home
                          home_selected = home;
                          isSelected[structures.indexOf(home)] = true;
                        });
                        // TODO -get the devices corresponding to this structure
                        // By default home 1 devices will be displayed
                        //devices=[];
                      },
                      shape: CircleBorder(),
                      borderSide: BorderSide(
                        color: isSelected[structures.indexOf(home)]
                            ? Colors.black
                            : Colors.blue,
                        width: 3.0,
                      ),
                      child: Icon(Icons.home, size: 50.0, color: Colors.blue),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '$home',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: "PTSerifR"),
                    )
                  ],
                );
              }).toList(),
            ),
            Divider(
              height: 20.0,
              color: Colors.blue[50],
              thickness: 10.0,
              indent: 10.0,
              endIndent: 10.0,
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {},
                          title: Text('${devices[index]}',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                fontFamily: "PTSerifR",
                              )),
                          leading: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.dehaze,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
