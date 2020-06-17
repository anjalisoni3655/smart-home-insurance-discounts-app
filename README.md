# smart-home-insurance-discounts-app

smart-home-insurance-discounts-app is a demo app using google-nest public APIs 
to enable home insurance providers give discounts to home owners if they have certain smart devices at home.


**This is not an officially supported Google product.**

**To setup flutter app on android studio**:
1. Make sure flutter SDK is installed on your laptop.
2. Make sure flutter plugin and dart plugin has been installed on android studio. If not go to Help->Find Action->plugins and install flutter plugin.
3. Clone the repository and open the home_insurance_app from android studio
4. Go to settings -> flutter and add the path to flutter SDK if not already present.
5. Connect device/ emulator and run the app.

**To setup the credentials  for the OAuth2.0 flow**
To get the access to SDM API, one can follow the detailed instructions given in SDM API official documentation. Here is the link for the same https://developers.google.com/home/smart-device-management/consumer/get-started

1.Add the latest version of flutter_config package in the pubspec.yaml file below the dev_dependencies section.

2.Create a .env file in the root of the project and store all the credentials:

API_URL= url used for resource picker and OAuth flow

API_URL2= url used for SDM API call

API_CLIENTID=some client id from the OAuth token

API_CLIENTSECRET= the client secret from the OAuth token.

API_SCOPE= the scope string for SDM API

3.Also add this .env file in gitignore file once done and then test the app in the local device, then we can push the code to github safely.

4.In order to use the google sign in services, the google-services.json file obtained after registering of app in firebase console need to be pasted in the android/app/directory.

For detailed instruction on how to setup environment variables in the project follow this link:https://github.com/ByneappLLC/flutter_config

**To use firebase_remote_config to access the app credentials**:
1. We have to install the dependency firebase_remote_config(https://pub.dev/packages/firebase_remote_config) using  flutter pub get command and then import this library in the dart file.
2.We need to register the app in the firebase console and get a google-services.json file.
3. Add the google-services.json file in the android/app directory.
