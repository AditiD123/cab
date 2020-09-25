import "package:flutter/material.dart";
import 'package:cab/main.dart';
import 'package:cab/routes/routes.dart';
import 'package:cab/splash.dart';
import 'package:cab/login.dart';
import 'package:cab/home.dart';

//This file keep tracks of all routes to be included

class Router {
  static Route<dynamic> generateRoute(RouteSettings routesettings) {
    switch (routesettings.name) {
      case Routes.main:
        return MaterialPageRoute(builder: (_) => MyApp());
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => Login());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return MaterialPageRoute(builder: (_) => MyApp());
    }
  }
}
