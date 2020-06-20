import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:homeinsuranceapp/data/device_type.dart';
import 'package:homeinsuranceapp/data/offer_service.dart';
import 'package:homeinsuranceapp/pages/common_widgets.dart';
import 'package:homeinsuranceapp/pages/style/custom_widgets.dart';
import 'package:homeinsuranceapp/data/globals.dart' as globals;

import '../data/device_type.dart';

class MyDevices extends StatefulWidget {
  @override
  _MyDevicesState createState() => _MyDevicesState();
}

class _MyDevicesState extends State<MyDevices> {
  bool hasDeviceAccess;
  bool hasDevices;
  bool reload;
  bool loading;
  @override
  void initState() {
    reload = false;
    loading = false;
    hasDevices = globals.devices.isPresent;
    super.initState();
    hasDeviceAccess = hasAccess();
    if (hasDeviceAccess && !hasDevices) {
      loading = true;
      globals.sdk.getAllDevices().then((value) {
        setState(() {
          loading = false;
          if (value.isEmpty) {
            reload = true;
          }
          globals.devices = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CommonAppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenwidth / 100, vertical: screenheight / 100),
              child: Text(
                'My Devices',
                style: CustomTextStyle(fontSize: 30.0),
              ),
            ),
            CustomDivider(height: screenheight / 150, width: screenwidth / 50),
            hasDeviceAccess
                ? reload
                    ? Column(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenheight / 10,
                                  horizontal: screenwidth / 10),
                              child: Text(
                                  'Some error occured while fetching devices. Please try again.',
                                  style: CustomTextStyle(
                                    color: Colors.brown,
                                  ),
                                  textAlign: TextAlign.center)),
                          FloatingActionButton.extended(
                            icon: Icon(Icons.cached),
                            label: Text('Reload'),
                            onPressed: () {
                              globals.sdk.getAllDevices().then((value) {
                                setState(() {
                                  loading = false;
                                  if (value.isEmpty) {
                                    reload = true;
                                  }
                                  globals.devices = value;
                                });
                              });
                            },
                          )
                        ],
                      )
                    : loading
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                vertical: screenheight / 10,
                                horizontal: screenwidth / 10),
                            child: Text('Loading...',
                                style: CustomTextStyle(
                                    color: Colors.brown, fontSize: 20),
                                textAlign: TextAlign.center))
                        : Container(
                            height: screenheight * 0.60,
                            width: screenwidth * 0.90,
                            child: ListView(
                              children: List.from((globals.devices.value)
                                  .map((device) => Padding(
                                        key: Key('${device['customName']}'),
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenheight / 100,
                                            horizontal: screenwidth / 100),
                                        child: Card(
                                          color: Colors
                                              .white, // If selected then color of card is teal else no change in color
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            side: BorderSide(
                                              color: Colors.brown[100],
                                              width: 1.0,
                                            ),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              '${device['customName']}',
                                              textAlign: TextAlign.center,
                                            ),
                                            subtitle: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      'Type: ${deviceName[sdmToDeviceType[device['type']].index]}'),
                                                ),
//                                  Padding(
//                                    padding: const EdgeInsets.all(8.0),
//                                    child: Text('Structure: ${device['structure']}'),
//                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.all(8.0),
//                                    child: Text('Room: ${device['room']}'),
//                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ))),
                            ),
                          )
                : Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: screenheight / 10,
                                horizontal: screenwidth / 10),
                            child: Text(
                                'Device Access not provided. Please link devices to view your devices.',
                                style: CustomTextStyle(
                                  color: Colors.brown,
                                ),
                                textAlign: TextAlign.center)),
                        FloatingActionButton.extended(
                          label: Text('Link Devices'),
                          onPressed: () async {
                            String status =
                                await globals.sdk.requestDeviceAccess();
                            setState(() {
                              hasDeviceAccess = hasAccess();
                              if (hasDeviceAccess) {
                                loading = true;
                                globals.sdk.getAllDevices().then((value) {
                                  setState(() {
                                    loading = false;
                                    if (value.isEmpty) {
                                      reload = true;
                                    } else {
                                      globals.devices = value;
                                    }
                                  });
                                });
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
