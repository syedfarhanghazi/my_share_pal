import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_share_pal/screens/home_screen.dart';
import 'package:my_share_pal/screens/register_screen.dart';
import 'package:my_share_pal/styleguide/colors.dart';
import 'package:my_share_pal/utils/session_manager.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  SessionManager _sessionManager = SessionManager();

  @override
  void initState() {
    _sessionManager.load();

    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: null,
        body: Container(
          decoration: BoxDecoration(gradient: radialGradient),
          child: SafeArea(
              child: Center(
            child: Container(
              margin: EdgeInsets.all(32.0),
              width: double.infinity,
              child: Image(image: AssetImage("images/logo.png")),
            ),
          )),
        ));
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    if (_sessionManager.isLogin == true) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => RegisterScreen()));
    }
  }
}
