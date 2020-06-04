import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sdk/services/login.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

void main() {
  test('test 1: api logging in and logging out without throwing any exceptions',
      () async {
    MockGoogleSignIn mockGoogleSignIn = new MockGoogleSignIn();
    MockGoogleSignInAccount mockGoogleSignInAccount =
        new MockGoogleSignInAccount();

    Future<GoogleSignInAccount> futureMockAccount(
            Invocation invocation) async =>
        mockGoogleSignInAccount;
    Future<bool> futureTrueInstance(Invocation invocation) async => true;
    Future<bool> futureFalseInstance(Invocation invocation) async => false;

    // Defining the behavior of mockGoogleSignIn.
    // Should not throw any error and return smoothly
    when(mockGoogleSignIn.signIn()).thenAnswer(futureMockAccount);
    when(mockGoogleSignIn.signOut()).thenAnswer(futureMockAccount);
    when(mockGoogleSignIn.currentUser).thenReturn(mockGoogleSignInAccount);

    // The account should return the following dummy details
    when(mockGoogleSignInAccount.displayName).thenReturn("Osheen Sachdev");
    when(mockGoogleSignInAccount.email).thenReturn("osheen@google.com");
    when(mockGoogleSignInAccount.photoUrl).thenReturn("someurl.com");
    when(mockGoogleSignIn.isSignedIn()).thenAnswer(futureFalseInstance);

    Login login = new Login.test(mockGoogleSignIn);

    //Expected output:
    expect(await login.logout(), "not logged in");
    expect(await login.getUserDetails(), null);
    expect(await login.login(), "login successful");
    // Behaviour update: After successful login the isSignedIn function should return true
    when(mockGoogleSignIn.isSignedIn()).thenAnswer(futureTrueInstance);
    // Expected output:
    expect(await login.getUserDetails(), {
      'displayName': "Osheen Sachdev",
      'email': "osheen@google.com",
      'photoUrl': "someurl.com"
    });
    expect(await login.login(), "already logged in");
    expect(await login.logout(), "logout successful");
    // Behaviour update: On successful logout the isSignedIn function should return false
    when(mockGoogleSignIn.isSignedIn()).thenAnswer(futureFalseInstance);
    // Expected output:
    expect(await login.getUserDetails(), null);
  });

  test('test 2: api throwing an error on signIn request', () async {
    MockGoogleSignIn mockGoogleSignIn = new MockGoogleSignIn();
    MockGoogleSignInAccount mockGoogleSignInAccount =
        new MockGoogleSignInAccount();

    Future<GoogleSignInAccount> futureMockAccount(
            Invocation invocation) async =>
        mockGoogleSignInAccount;
    Future<bool> futureTrueInstance(Invocation invocation) async => true;
    Future<bool> futureFalseInstance(Invocation invocation) async => false;

    // Defining the behavior of mockGoogleSignIn.
    // Throws an error on signing in
    when(mockGoogleSignIn.signIn()).thenThrow(new Exception());
    when(mockGoogleSignIn.isSignedIn()).thenAnswer(futureFalseInstance);
    when(mockGoogleSignIn.currentUser).thenReturn(mockGoogleSignInAccount);

    Login login = new Login.test(mockGoogleSignIn);
    // Expected output:
    expect(await login.login(), "login failed");
    expect(await login.getUserDetails(), null);
  });

  // test needs to be run separately as sign out would simply return not signed in if both sign in and sign out throw error
  test('test 3: api throwing an error on signOut request', () async {
    MockGoogleSignIn mockGoogleSignIn = new MockGoogleSignIn();
    MockGoogleSignInAccount mockGoogleSignInAccount =
        new MockGoogleSignInAccount();

    Future<GoogleSignInAccount> futureMockAccount(
            Invocation invocation) async =>
        mockGoogleSignInAccount;
    Future<bool> futureTrueInstance(Invocation invocation) async => true;
    Future<bool> futureFalseInstance(Invocation invocation) async => false;

    // Defining the behavior of mockGoogleSignIn.
    // Throws an error on signing out, no error on signing in
    when(mockGoogleSignIn.signIn()).thenAnswer(futureMockAccount);
    when(mockGoogleSignIn.signOut()).thenThrow(new Exception());
    when(mockGoogleSignIn.isSignedIn()).thenAnswer(futureFalseInstance);
    when(mockGoogleSignIn.currentUser).thenReturn(mockGoogleSignInAccount);

    // The account should return the following dummy details
    when(mockGoogleSignInAccount.displayName).thenReturn("Osheen Sachdev");
    when(mockGoogleSignInAccount.email).thenReturn("osheen@google.com");
    when(mockGoogleSignInAccount.photoUrl).thenReturn("someurl.com");

    Login login = new Login.test(mockGoogleSignIn);
    // Expected output:
    expect(await login.login(), "login successful");
    // Behaviour update: After successful login the isSignedIn function should return true
    when(mockGoogleSignIn.isSignedIn()).thenAnswer(futureTrueInstance);
    // Expected output:
    expect(await login.getUserDetails(), {
      'displayName': "Osheen Sachdev",
      'email': "osheen@google.com",
      'photoUrl': "someurl.com"
    });
    expect(await login.logout(), "logout failed");
    expect(await login.getUserDetails(), {
      'displayName': "Osheen Sachdev",
      'email': "osheen@google.com",
      'photoUrl': "someurl.com"
    });
  });

  test('test 4: api throwing an error on isSignedIn request', () async {
    MockGoogleSignIn mockGoogleSignIn = new MockGoogleSignIn();
    MockGoogleSignInAccount mockGoogleSignInAccount =
        new MockGoogleSignInAccount();

    Future<GoogleSignInAccount> futureMockAccount(
            Invocation invocation) async =>
        mockGoogleSignInAccount;
    Future<bool> futureTrueInstance(Invocation invocation) async => true;
    Future<bool> futureFalseInstance(Invocation invocation) async => false;

    // Defining the behavior of mockGoogleSignIn.
    // Throws an error on isSignedIn
    when(mockGoogleSignIn.signIn()).thenAnswer(futureMockAccount);
    when(mockGoogleSignIn.isSignedIn()).thenThrow(new Exception());
    when(mockGoogleSignIn.currentUser).thenReturn(mockGoogleSignInAccount);

    Login login = new Login.test(mockGoogleSignIn);
    // Expected output:
    expect(await login.login(), "login failed");
    expect(await login.getUserDetails(), null);
  });

  test('test 5: api takes longer to respond on signIn request than set timeout',
      () async {
    MockGoogleSignIn mockGoogleSignIn = new MockGoogleSignIn();
    MockGoogleSignInAccount mockGoogleSignInAccount =
        new MockGoogleSignInAccount();

    Future<GoogleSignInAccount> futureMockAccount(
            Invocation invocation) async =>
        mockGoogleSignInAccount;
    Future<bool> futureTrueInstance(Invocation invocation) async => true;
    Future<bool> futureFalseInstance(Invocation invocation) async => false;

    // Defining the behavior of mockGoogleSignIn.
    // Takes 200 ms to sign in
    when(mockGoogleSignIn.signIn()).thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return mockGoogleSignInAccount;
    });
    when(mockGoogleSignIn.isSignedIn()).thenAnswer(futureFalseInstance);
    when(mockGoogleSignIn.currentUser).thenReturn(mockGoogleSignInAccount);

    // Set timeout duration for user interactive queries to 100 ms (sign in is a user interactive query)
    Login login = new Login.test(mockGoogleSignIn,
        userInteractiveFlowTimeout: new Duration(milliseconds: 100));
    // Expected output:
    expect(await login.login(), "login failed");
    expect(await login.getUserDetails(), null);
  });

  test(
      'test 6: api takes longer to respond on signOut request than set timeout',
      () async {
    MockGoogleSignIn mockGoogleSignIn = new MockGoogleSignIn();
    MockGoogleSignInAccount mockGoogleSignInAccount =
        new MockGoogleSignInAccount();

    Future<GoogleSignInAccount> futureMockAccount(
            Invocation invocation) async =>
        mockGoogleSignInAccount;
    Future<bool> futureTrueInstance(Invocation invocation) async => true;
    Future<bool> futureFalseInstance(Invocation invocation) async => false;

    // Defining the behavior of mockGoogleSignIn.
    // Takes 200 ms to sign out
    when(mockGoogleSignIn.signIn()).thenAnswer(futureMockAccount);
    when(mockGoogleSignIn.signOut()).thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return mockGoogleSignInAccount;
    });
    when(mockGoogleSignIn.isSignedIn()).thenAnswer(futureFalseInstance);
    when(mockGoogleSignIn.currentUser).thenReturn(mockGoogleSignInAccount);

    // The account should return the following dummy details
    when(mockGoogleSignInAccount.displayName).thenReturn("Osheen Sachdev");
    when(mockGoogleSignInAccount.email).thenReturn("osheen@google.com");
    when(mockGoogleSignInAccount.photoUrl).thenReturn("someurl.com");
    when(mockGoogleSignIn.isSignedIn()).thenAnswer(futureFalseInstance);

    // Set timeout duration for non user interactive queries to 100 ms (sign out is a non user interactive query)
    Login login = new Login.test(mockGoogleSignIn,
        nonUserInteractiveFlowTimeout: new Duration(milliseconds: 100));
    // Expected output:
    expect(await login.login(), "login successful");
    // Behaviour update: After successful login the isSignedIn function should return true
    when(mockGoogleSignIn.isSignedIn()).thenAnswer(futureTrueInstance);
    // Expected output:
    expect(await login.getUserDetails(), {
      'displayName': "Osheen Sachdev",
      'email': "osheen@google.com",
      'photoUrl': "someurl.com"
    });
    expect(await login.logout(), "logout failed");
    expect(await login.getUserDetails(), {
      'displayName': "Osheen Sachdev",
      'email': "osheen@google.com",
      'photoUrl': "someurl.com"
    });
  });

  test(
      'test 7: api takes longer to respond on isSignedIn request than set timeout',
      () async {
    MockGoogleSignIn mockGoogleSignIn = new MockGoogleSignIn();
    MockGoogleSignInAccount mockGoogleSignInAccount =
        new MockGoogleSignInAccount();

    Future<GoogleSignInAccount> futureMockAccount(
            Invocation invocation) async =>
        mockGoogleSignInAccount;
    Future<bool> futureTrueInstance(Invocation invocation) async => true;
    Future<bool> futureFalseInstance(Invocation invocation) async => false;

    // Defining the behavior of mockGoogleSignIn.
    // Takes 200 ms to check isSignedIn
    when(mockGoogleSignIn.isSignedIn()).thenAnswer((_) async {
      await Future.delayed(new Duration(milliseconds: 200));
      return false;
    });
    when(mockGoogleSignIn.isSignedIn()).thenAnswer(futureFalseInstance);
    when(mockGoogleSignIn.currentUser).thenReturn(mockGoogleSignInAccount);

    // Set timeout duration for non-user interactive queries to 100 ms (isSignedin is a non-user interactive query)
    Login login = new Login.test(mockGoogleSignIn,
        nonUserInteractiveFlowTimeout: new Duration(milliseconds: 100));
    // Expected output:
    expect(await login.login(), "login failed");
    expect(await login.getUserDetails(), null);
  });
}
