import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sdk/services/login.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

MockGoogleSignIn mockGoogleSignIn;
MockGoogleSignInAccount mockGoogleSignInAccount;

void main() {
  setUp(() {
    mockGoogleSignIn = MockGoogleSignIn();
    mockGoogleSignInAccount = MockGoogleSignInAccount();

    // Defining the behavior of mockGoogleSignIn.
    // Should not throw any error and return smoothly
    when(mockGoogleSignIn.signIn())
        .thenAnswer((_) => Future.value(mockGoogleSignInAccount));
    when(mockGoogleSignIn.signOut())
        .thenAnswer((_) => Future.value(mockGoogleSignInAccount));
    when(mockGoogleSignIn.currentUser).thenReturn(mockGoogleSignInAccount);

    // The account should return the following dummy details
    when(mockGoogleSignInAccount.displayName).thenReturn("Osheen Sachdev");
    when(mockGoogleSignInAccount.email).thenReturn("osheen@google.com");
    when(mockGoogleSignInAccount.photoUrl).thenReturn("someurl.com");
    when(mockGoogleSignIn.isSignedIn()).thenAnswer((_) => Future.value(false));
  });

  test('test 1.1: api logging in successfully', () async {
    Login login = new Login.test(mockGoogleSignIn);
    // Default setup serves the purpose for this test no alteration in configuation required
    // Expected result: login should return login successful
    expect(await login.login(), "login successful");
  });

  test('test 1.2: already logged in', () async {
    Login login = new Login.test(mockGoogleSignIn);
    // Update isSignedIn API method to return true
    when(mockGoogleSignIn.isSignedIn()).thenAnswer((_) => Future.value(true));
    // expected result: login should return status message "already logged in"
    expect(await login.login(), "already logged in");
  });

  test('test 1.3: api throws exception on signIn attempt', () async {
    Login login = new Login.test(mockGoogleSignIn);
    // update signIn to throw error on call
    when(mockGoogleSignIn.signIn()).thenThrow(new Exception('test'));
    // Expected result : login should fail
    expect(await login.login(), "login failed");
  });

  test('test 1.4: api takes longer than timeout set on signIn attempt',
      () async {
    Login login = new Login.test(mockGoogleSignIn,
        interactiveFlowTimeout: new Duration(milliseconds: 100));
    // update signIn to respond after 200 ms, timeout set to 100 ms
    when(mockGoogleSignIn.signIn()).thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return mockGoogleSignInAccount;
    });
    // Expected result : login should fail
    expect(await login.login(), "login failed");
  });

  test('test 2.1: api logs out successfully', () async {
    Login login = new Login.test(mockGoogleSignIn);
    // Update isSignedIn API method to return true since should be already logged in for successful logout
    when(mockGoogleSignIn.isSignedIn()).thenAnswer((_) => Future.value(true));
    // Expected result: login should return login successful
    expect(await login.logout(), "logout successful");
  });

  test('test 2.2: not logged in', () async {
    Login login = new Login.test(mockGoogleSignIn);
    // Default configuration fit. No extra update on behaviour required
    // expected result: logout should return status message "not logged in"
    expect(await login.logout(), "not logged in");
  });

  test('test 2.3: api throws exception on signOut attempt', () async {
    Login login = new Login.test(mockGoogleSignIn);
    // Update isSignedIn API method to return true since should be already logged in for logout attempt
    when(mockGoogleSignIn.isSignedIn()).thenAnswer((_) => Future.value(true));
    // update signOut to throw error on call
    when(mockGoogleSignIn.signOut()).thenThrow(new Exception('test'));
    // Expected result : logout should fail
    expect(await login.logout(), "logout failed");
  });

  test('test 2.4: api takes longer than timeout set on signOut attempt',
      () async {
    Login login = new Login.test(mockGoogleSignIn,
        nonInteractiveFlowTimeout: new Duration(milliseconds: 100));
    // Update isSignedIn API method to return true since should be already logged in for logout attempt
    when(mockGoogleSignIn.isSignedIn()).thenAnswer((_) => Future.value(true));
    // update signOut to respond after 200 ms, timeout set to 100 ms
    when(mockGoogleSignIn.signOut()).thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return mockGoogleSignInAccount;
    });
    // Expected result : logout should fail
    expect(await login.logout(), "logout failed");
  });

  test('test 3.1: get user details successfully when logged in', () async {
    Login login = new Login.test(mockGoogleSignIn);
    // Update isSignedIn API method to return true since should be already logged in for successful getUserDetails
    when(mockGoogleSignIn.isSignedIn()).thenAnswer((_) => Future.value(true));
    // Expected result: getUserDetails should return mock details
    expect(await login.getUserDetails(), {
      'displayName': "Osheen Sachdev",
      'email': "osheen@google.com",
      'photoUrl': "someurl.com"
    });
  });

  test('test 3.2: api throws exception on getting current user attempt',
      () async {
    Login login = new Login.test(mockGoogleSignIn);
    // update signIn to throw error on call
    when(mockGoogleSignIn.currentUser).thenThrow(new Exception('test'));
    // Expected result : getUserDetails should return null
    expect(await login.getUserDetails(), null);
  });

  test('test 3.4: api takes longer than timeout to check isSignedIn attempt',
      () async {
    Login login = new Login.test(mockGoogleSignIn,
        nonInteractiveFlowTimeout: new Duration(milliseconds: 100));
    // update signIn to respond after 200 ms, timeout set to 100 ms
    when(mockGoogleSignIn.isSignedIn()).thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return true;
    });
    // Expected result : getUserDetails should return null
    expect(await login.getUserDetails(), null);
  });
}
