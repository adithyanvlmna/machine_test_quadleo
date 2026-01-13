import 'package:flutter/material.dart';
import 'package:machine_test_quadleo/screens/auth/login_screen.dart';
import 'package:machine_test_quadleo/screens/auth/registre_screen.dart';
import 'package:machine_test_quadleo/screens/splash_screen.dart';


class Routes {
  static const String splashScreen = "splashScreen";
  static const String registerScreen = "registerScreen";
  static const String loginScreen = "loginScreen";
  static const String homeScreen = "homeScreen";

  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.splashScreen: (ctx) => SplashScreen(),
    Routes.registerScreen: (ctx) => RegisterScreen(),

    Routes.loginScreen: (ctx) => LoginScreen(),


  };
}
