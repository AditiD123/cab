import 'package:flutter/material.dart';
import 'package:cab/splash.dart';
import 'package:cab/routes/route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      onGenerateRoute: Router.generateRoute,
    );
  }
}
