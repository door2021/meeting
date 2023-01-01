import 'package:athelets/Utils/routes_names.dart';
import 'package:athelets/devices/mobile/ArrangeMeetingScreen.dart';
import 'package:athelets/devices/mobile/Authentication/ForgotPasswordScreen.dart';
import 'package:athelets/devices/mobile/Authentication/SignInScreen.dart';
import 'package:athelets/devices/mobile/Authentication/SignUpScreen.dart';
import 'package:athelets/devices/mobile/Tabs/MainScreen.dart';
import 'package:athelets/devices/mobile/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case RouteName.Splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case RouteName.SignIn:
        return MaterialPageRoute(builder: (context) => SignIn());

      case RouteName.SignUp:
        return MaterialPageRoute(builder: (context) => SignUp());

      case RouteName.ForgotPassword:
        return MaterialPageRoute(builder: (context) => ForgotPassword());

      case RouteName.Main:
        return MaterialPageRoute(builder: (context) => Main());

      case RouteName.arrangeMeeting:
        print(args);
        if(args is String){
          return MaterialPageRoute(builder: (context) => ArrangeMeeting(uid: args,));
        }
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('Oops ! Something went wrong, try again.'),
            ),
          );
        });

        default:
          return MaterialPageRoute(builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text('Oops ! Something went wrong, try again.'),
            ),
          );
        });
    }
  }
}
