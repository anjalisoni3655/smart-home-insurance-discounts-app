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
        color: Colors.brown[50],
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
                            child: ListView(
                              children: List.from((globals.devices.value)
                                  .map((device) => Padding(
                                        key: Key('${device['customName']}'),
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenheight / 150,
                                            horizontal: screenwidth / 20),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: screenheight/50, horizontal: screenwidth/30),
                                          color: Colors.brown[100],
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                //If device name is empty display Unknown
                                                device['customName'] != ""
                                                    ? '${device['customName']}'
                                                    : "Unknown",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17
                                                ),
                                              ),
                                              Text(
                                                  'Type: ${deviceName[sdmToDeviceType[device['type']].index]}',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.grey[600]
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  )
                              ),
                            ),
                          )
                : Container(),
            // The user can link to devices anytime .
            Container(
              child: Column(
                children: <Widget>[
                  !hasDeviceAccess
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              vertical: screenheight / 10,
                              horizontal: screenwidth / 10),
                          child: Text(
                              'Device Access not provided. Please link devices to view your devices.',
                              style: CustomTextStyle(
                                color: Colors.brown,
                              ),
                              textAlign: TextAlign.center))
                      : Container(),
                  FloatingActionButton.extended(
                    label: Text('Link Devices'),
                    onPressed: () async {
                      String status = await globals.sdk.requestDeviceAccess();
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
