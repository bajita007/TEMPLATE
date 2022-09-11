import 'dart:async';

import 'package:comindors/Login/LoginScreen.dart';
import 'package:comindors/Page/WelcomePage.dart';
import 'package:comindors/Ui/StringData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Ui/StyleText.dart';
import '../Ui/TopHeader.dart';
import '../Ui/Warna.dart';
import '../Ui/circle.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startLaunching();
  }

  startLaunching() async {
    SharedPreferences loginCheck = await SharedPreferences.getInstance();

    var duration = const Duration(seconds: 3);
    return Timer(duration, () async {
      String? seen = loginCheck.getString(StringData.id_user);
      String? status = loginCheck.getString(StringData.user_status);

      if (seen == null || status == null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => WelcomePage()));
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: CustomPaint(
              painter: CircleOne(Colors.blue.withAlpha(80)),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: CustomPaint(
              painter: CircleOne(Colors.blue.withAlpha(80)),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CustomPaint(
              painter: CircleTwo(Colors.red.withAlpha(80)),
            ),
          ),
          Align(
            alignment: const Alignment(1.0, -0.5),
            child: CustomPaint(
              painter: CircleTwo(Colors.red.withAlpha(80)),
            ),
          ),
          Align(
            alignment: const Alignment(-1.0, -0.03),
            child: CustomPaint(
              painter: CircleTwo(Colors.blue.withAlpha(80)),
            ),
          ),
          Align(
            alignment: const Alignment(1.0, 0.3),
            child: CustomPaint(
              painter: CircleTwo(Colors.red.withAlpha(80)),
            ),
          ),


          Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [

                  logo(40),
                ],
              ),
            ),
          )
          //
        ]));
  }
}
