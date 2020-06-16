import 'package:test/test.dart';
import 'package:flutter_driver/flutter_driver.dart';

// Note: Please use flutterDriver.runUnsynchronized(() if animation on page


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
      SerializableFinder loginButton = find.text('LOG IN WITH GOOGLE');
      await Future.delayed(const Duration(seconds: 1));
      await flutterDriver.runUnsynchronized(() async {
        await flutterDriver.tap(loginButton);
      });
    });

    //  Find sidebar button and click on it. Select "Purchase Policy"
    test("Home Page", () async {
      SerializableFinder appDrawer = find.byTooltip('Open navigation menu');
      await flutterDriver.tap(appDrawer);
      SerializableFinder purchaseTab = find.text("Purchase Policy");
      await flutterDriver.tap(purchaseTab);
      await Future.delayed(const Duration(seconds: 1));
    });

    //  Find address textboxes and fill them. Click on submit.
    test("Enter address", () async {
      SerializableFinder firstLineTextBox = find.byValueKey("First Address Line");
      await flutterDriver.tap(firstLineTextBox);
      await flutterDriver.enterText("A9 704, Tulip White");

      SerializableFinder secondLineTextBox = find.byValueKey("Second Address Line");
      await flutterDriver.tap(secondLineTextBox);
      await flutterDriver.enterText("sector 69");

      SerializableFinder cityTextBox = find.byValueKey("City");
      await flutterDriver.tap(cityTextBox);
      await flutterDriver.enterText("Gurgaon");

      SerializableFinder stateTextBox = find.byValueKey("State");
      await flutterDriver.tap(stateTextBox);
      await flutterDriver.enterText("Haryana");

      SerializableFinder pincodeTextBox = find.byValueKey("Pincode");
      await flutterDriver.tap(pincodeTextBox);
      await flutterDriver.enterText("122101");

      SerializableFinder submitButton = find.text("SUBMIT");
      await flutterDriver.tap(submitButton);

      await Future.delayed(const Duration(seconds: 1));
    });

    //  Find radio buttons and policy names and select a policy
    //  Find "Smart Discounts" button and click on it
    test("Choose Policy", () async {
      SerializableFinder secondPolicy = find.byValueKey("Policy 1"); // 0 indexed
      await flutterDriver.tap(secondPolicy);

      SerializableFinder viewDiscountsButton = find.text("View Smart Device Discounts");
      await flutterDriver.tap(viewDiscountsButton);

      await Future.delayed(const Duration(seconds: 2));
    });

    //  Find "Add Devices" button and click on it
    test("Smart Discounts Page", () async {
      SerializableFinder addDevicesButton = find.text("Add Devices");
      await flutterDriver.tap(addDevicesButton);

      await Future.delayed(const Duration(seconds: 1));
    });
    
    //  Find the first a structure and select
    test("Select Structure", () async {
      SerializableFinder secondStructure = find.byValueKey("Structure 1");
      await flutterDriver.tap(secondStructure);

      SerializableFinder submitButton = find.text("Submit");
      await flutterDriver.tap(submitButton);

      Future.delayed(const Duration(seconds: 1));
    });

    // TODO:  Find list of offers and confirm that only offers that can be availed are present

    //  Select an offer and click on "Go to Payment"
    test("Select Offer", () async {
      SerializableFinder firstOffer = find.byValueKey("Offer 0");
      await flutterDriver.tap(firstOffer);

      SerializableFinder submitButton = find.text("Go to Payment");
      await flutterDriver.tap(submitButton);

      Future.delayed(const Duration(seconds: 1));
    });

    //TODO:  Check if address, offers, structure and policies displayed are the ones chosen.

    //  Find "Pay" button and click on it
    test("Confirm Payment", () async {
      await flutterDriver.scroll(find.byType("MaterialApp"), 0, -100, const Duration(milliseconds: 100));
      SerializableFinder confirmPaymentButton = find.text("Confirm Payment");
      await flutterDriver.tap(confirmPaymentButton);

      await Future.delayed(const Duration(seconds: 1));
    });
  });
}