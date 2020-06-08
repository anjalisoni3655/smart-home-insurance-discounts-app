import 'package:flutter/material.dart';

//Information derived from API calls
List<String> structures = ["Home1", "Home2", "Home3", "Home4"];
//List<String> devices =[];

class MyDevices extends StatefulWidget {
  @override
  _MyDevicesState createState() => _MyDevicesState();
}

List<String> devices = [
  "ThermostatT1",
  "ThermostatT2",
  "DoorbellD1",
  "Smoke DetectorSD1",
  "Smoke DetectorSD2",
  "ThermostatT1",
  "ThermostatT2",
  "DoorbellD1",
  "Smoke DetectorSD1",
  "Smoke DetectorSD2",
];

class _MyDevicesState extends State<MyDevices> {
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
                'MY DEVICES',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  fontFamily:"PTSerifBI",
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: structures.map((home) {
                return Column(
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: () {},
                      shape: CircleBorder(
                          //color:Colors.red,
                          ),
                      elevation: 4.0,
                      fillColor: Colors.white,
                      child: Icon(Icons.home, size: 50.0, color: Colors.blue),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '$home',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        fontFamily:"PTSerifR"
                      ),
                    )
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
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
                                  fontFamily:"PTSerifR",
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
