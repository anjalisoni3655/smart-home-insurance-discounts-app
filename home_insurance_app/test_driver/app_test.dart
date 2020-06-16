import 'package:test/test.dart';
import 'package:flutter_driver/flutter_driver.dart';


Future<FlutterDriver> setupAndGetDriver() async {
  FlutterDriver driver = await FlutterDriver.connect();
  var connected = false;
  while (!connected) {
    try {
      await driver.waitUntilFirstFrameRasterized();
      connected = true;
    } catch (error) {}
  }
  return driver;
}

void main() {
  group("End-to-end flow with offer", () {
    FlutterDriver flutterDriver;
    setUpAll(() async {
      flutterDriver = await setupAndGetDriver();
    });

    tearDownAll(() async {
      if(flutterDriver != null) {
        flutterDriver.close();
      }
    });

    //  Start at login page
    //  Find "Login with Google" button and click on it
    test("Login Page", () async {
      var loginButton = find.text('LOG IN WITH GOOGLE');
      await flutterDriver.runUnsynchronized(() async {
        await flutterDriver.waitFor(loginButton);
      });
      print('button found finally :/');
      await Future.delayed(const Duration(seconds: 1));
      await flutterDriver.runUnsynchronized(() async {
        await flutterDriver.tap(loginButton);
      });
      await Future.delayed(const Duration(seconds: 1));

    });
    //  Find sidebar button and click on it
    //  Sidebar with "Purchase Policy" tab should open up. Click on "Purchase Policy"
    //  Find address textboxes and fill them
    //  Find "Submit" button and click on it
    //  Find radio buttons and policy names and select a policy
    //  Find "Smart Discounts" button and click on it
    //  Find "Add Devices" button and click on it
    //  Find pop up for selecting a structure. Select a structure from list
    //  Find list of offers and confirm that only offers that can be availed are present
    //  Select an offer
    //  Find "Proceed To Payment" button and click on it
    //  Check if address, offers, structure and policies displayed are correct.
    //  Find "Pay" button and click on it
  });
}