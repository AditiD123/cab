import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:cab/routes/routes.dart';
import 'package:cab/constants/strings.dart';
import 'package:simple_animations/simple_animations.dart';
import 'dart:async';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Stack(
            alignment: Alignment(0, 0),
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            // children below are stacked and mentioned separately
            children: <Widget>[
              Positioned(
                bottom: 40,
                child: FadeIn(
                  1.5,
                  AppName(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _displayToast(String message) {
    /*
    This function will initialize a toast snackBar with the passed message String
    */

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  startTimer() async {
    var _duration = Duration(milliseconds: 5000);

    final bool connection = await isConnected();

    if (connection) // Connected To Internet
    {
      Timer(_duration, navigate);
    } else // Internet Connection Is Not Available
    {
      _displayToast("An Internet Connection Is Required.");
      //  Re-checks for internet availability again, after fixed _duration.
      Timer(_duration, startTimer);
    }
  }

  navigate() async {
    Navigator.of(context).pushNamed(Routes.login);
  }

  Future<bool> isConnected() async {
    var _connectionResult = await (Connectivity().checkConnectivity());

    if (_connectionResult == ConnectivityResult.mobile ||
        _connectionResult == ConnectivityResult.wifi) {
      return Future.value(true);
    }

    return Future.value(false);
  }
}

enum _AniProps { opacity, translateY }

class FadeIn extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeIn(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniProps>()
      ..add(_AniProps.opacity, Tween(begin: 0.0, end: 1.0),
          Duration(milliseconds: 500))
      ..add(_AniProps.translateY, Tween(begin: -30.0, end: 0.0),
          Duration(milliseconds: 500), Curves.easeOut);

    return PlayAnimation<MultiTweenValues<_AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(_AniProps.opacity),
        child: Transform.translate(
          offset: Offset(value.get(_AniProps.translateY), 0),
          child: child,
        ),
      ),
    );
  }
}

class AppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      Strings.app_name,
      textDirection: TextDirection.ltr,
      style: TextStyle(
        fontSize: 50,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }
}
