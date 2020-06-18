import 'package:test/test.dart';
import 'package:flutter_driver/flutter_driver.dart';

// Note: All functions assume that the driver is on the correct page and checks if redirected to the correct next page.
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

FlutterDriver flutterDriver;

//dynamic openApp() async {
//  SerializableFinder loadingText = find.text('Loading');
//  await flutterDriver.waitFor(find.byType("HomePage"));
//}

//Go back to the previous page
dynamic goBack() async {
  final backButton = find.byTooltip('Back');
  await flutterDriver.tap(backButton);
}

//Check the presence of
//isPresent(SerializableFinder byValueKey, FlutterDriver driver,
//    {Duration timeout = const Duration(seconds: 1)}) async {
//  try {
//    await driver.waitFor(byValueKey, timeout: timeout);
//    return true;
//  } catch (exception) {
//    return false;
//  }
//}

// Clicks on LOGIN WITH GOOGLE button and checks if directed to homepage
dynamic login() async {
  SerializableFinder loginButton = find.text('LOG IN WITH GOOGLE');
  await flutterDriver.runUnsynchronized(() async {
    await flutterDriver.tap(loginButton);
  });

  await flutterDriver.waitFor(find.byType("HomePage"));
}

// Opens app drawer and selects purchase policy tab. Checks if next page opens.
dynamic homePageSelectPurchasePolicyTab() async {
  SerializableFinder appDrawer = find.byTooltip('Open navigation menu');
  await flutterDriver.tap(appDrawer);
  SerializableFinder purchaseTab = find.text("Purchase Policy");
  await flutterDriver.tap(purchaseTab);
  await flutterDriver.waitFor(find.byType("HomeDetails"));
}

// Opens app drawer and select the Smart Device  Discounts Tab . Checks if next page opens.
dynamic menuBarSmartDeviceDiscountsTab() async {
  SerializableFinder appDrawer = find.byTooltip('Open navigation menu');
  await flutterDriver.tap(appDrawer);
  SerializableFinder purchaseTab = find.text("Smart Devices Discounts");
  await flutterDriver.tap(purchaseTab);
  await flutterDriver.waitFor(find.byType("DisplayDiscounts"));

  //Check that the page is only for viewing discounts
//  final isExists = await isPresent(find.byValueKey('textKey'), flutterDriver);
//  if (isExists) {
//    print('widget is present');
//  } else {
//    print('widget is not present');
//  }

  await goBack();
  await flutterDriver.waitFor(find.byType("HomePage"));
}

// Opens app drawer and select the Contact Us Tab . Checks if next page opens.
dynamic menuBarContactUsTab() async {
  SerializableFinder appDrawer = find.byTooltip('Open navigation menu');
  await flutterDriver.tap(appDrawer);
  SerializableFinder purchaseTab = find.text('Contact Us');
  await flutterDriver.tap(purchaseTab);
  await flutterDriver.waitFor(find.byType("Contact"));
  //GoBack to home page
  await goBack();
  await flutterDriver.waitFor(find.byType("HomePage"));
}

// Enter address and click on submit. Check if redirected to choose policy
dynamic enterAddress() async {
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

  await flutterDriver.waitFor(find.byType("DisplayPolicies"));
}

// Choose second policy from the list of policies (second because first is already chosen)
dynamic choosePolicy() async {
  SerializableFinder secondPolicy = find.byValueKey("Policy 1"); // 0 indexed
  await flutterDriver.tap(secondPolicy);
}

// Click on View Smart Device Discounts on Policy Page
dynamic viewSmartDiscountsAfterPolicy() async {
  SerializableFinder viewDiscountsButton =
      find.text("Avail Smart Device Discounts");
  await flutterDriver.tap(viewDiscountsButton);

  await flutterDriver.waitFor(find.byType("DisplayDiscounts"));
}


// Click on Payment on Policy Page
dynamic paymentAfterPolicy() async {
  SerializableFinder paymentButton = find.text("Skip to Payment");
  await flutterDriver.tap(paymentButton);

  await flutterDriver.waitFor(find.byType("Payment"));
}


// Click on add devices on Show Discounts page
dynamic addDevices() async {
  SerializableFinder addDevicesButton = find.text("Link Devices");
  await flutterDriver.tap(addDevicesButton);
}

// Select structure and submit when pop up already present.
dynamic selectStructure() async {
  SerializableFinder secondStructure = find.byValueKey("Structure 1");
  await flutterDriver.tap(secondStructure);

  SerializableFinder submitButton = find.text("Submit");
  await flutterDriver.tap(submitButton);
}

// Select first offer that appears after selecting devices. Select Go to payment (submit selection)
// TODO: if no offer present select go to payment directly
dynamic selectOffer() async {
  SerializableFinder firstOffer = find.byValueKey("Offer 0");
  await flutterDriver.tap(firstOffer);

  SerializableFinder submitButton = find.text("Go to Payment");
  await flutterDriver.tap(submitButton);

  await flutterDriver.waitFor(find.byType("Payment"));
//      await Future.delayed(const Duration(seconds: 1));
}

// Click on confirm payment on payments page. Check if redirected to home page
dynamic confirmPayment() async {
  await flutterDriver.scroll(
      find.byType("MaterialApp"), 0, -100, const Duration(milliseconds: 100));
  SerializableFinder confirmPaymentButton = find.text("Confirm Payment");
  await flutterDriver.tap(confirmPaymentButton);

  await flutterDriver.waitFor(find.byType("HomePage"));
}

// Click on confirm payment on payments page. Check if redirected to home page
dynamic cancelPayment() async {
  await flutterDriver.scroll(
      find.byType("MaterialApp"), 0, -100, const Duration(milliseconds: 100));
  SerializableFinder confirmPaymentButton = find.text("Cancel Payment");
  await flutterDriver.tap(confirmPaymentButton);

  await flutterDriver.waitFor(find.byType("HomePage"));
}

// Click on logout on home page. Check if redirected to login page.
dynamic logout() async {
  await flutterDriver.waitFor(find.byType("HomePage"));

  SerializableFinder settingsButton = find.byValueKey("settings");
  await flutterDriver.tap(settingsButton);

  SerializableFinder logout = find.text("Logout");
  flutterDriver.tap(logout);

  await flutterDriver.waitFor(find.byType("LoginScreen"));
}
dynamic onlyBuyPolicy() async {
  await homePageSelectPurchasePolicyTab();
  await enterAddress();
  await choosePolicy();
  await paymentAfterPolicy();
  await confirmPayment();

}

void main() {
  group("End-to-end flow with offer", () {
    setUpAll(() async {
      flutterDriver = await setupAndGetDriver();
    });

    tearDownAll(() async {
      if (flutterDriver != null) {
        flutterDriver.close();
      }
    });

    // test("Loading Page",openApp);
    // either login or home page

    //  Start at login page
    //  Find "Login with Google" button and click on it
    test("Login Page", login);

//    test("Only Buy Policy" , onlyBuyPolicy);

    //  Find sidebar button and click on it. Select "Purchase Policy"
     test("Home Page", homePageSelectPurchasePolicyTab);

//
//    //  Find address textboxes and fill them. Click on submit.
    test("Enter address", enterAddress);
//
    //  Find radio buttons and policy names and select a policy
    test("Choose Policy", choosePolicy);
//
//    //  Find "Smart Discounts" button and click on it
    test("View Smart Discounts button", viewSmartDiscountsAfterPolicy);
//
//    //  Find "Add Devices" button and click on it
//    test("Smart Discounts Page", addDevices);
//
//    //  Find the first a structure and select
//    test("Select Structure", selectStructure);
//
//    // TODO:  Find list of offers and confirm that only offers that can be availed are present
//
//    //  Select an offer and click on "Go to Payment"
//    test("Select Offer", selectOffer);
//
//    //TODO:  Check if address, offers, structure and policies displayed are the ones chosen.
//
//    //  Find "Pay" button and click on it
//    test("Confirm Payment", confirmPayment);

//    test("View Discounts", menuBarSmartDeviceDiscountsTab);
//    test("Contact Company", menuBarContactUsTab);
//
//
//
//    // Check if redirected to home page and Logout
//    test("Logout", logout);
  });
}
