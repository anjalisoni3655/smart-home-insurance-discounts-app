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

** To setup the credentials  for the OAuth2.0 flow**
1. Add the latest version of flutter_config package in the pubspec.yaml file below the dev_dependencies section.
2. Create a .env file in the root of the project and store all the credentials:
API_ID= abdff
API_URL=https://github.com
3.Also add this .env file in gitignore file once done and then test the app in the local device, then we can push the code to github safely.
For detailed instruction on how to setup environment variables in the project follow this link:https://github.com/ByneappLLC/flutter_config
