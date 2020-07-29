import 'dart:async';

import 'package:flutter/material.dart';
import 'package:olxapp/screens/baseScreen/base_screen.dart';
import 'package:olxapp/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/flipLoader/flip.dart';
class Splash  extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  startTime() async {
    final prefs =  await SharedPreferences.getInstance();

    var duration = new Duration(seconds: 5);
    return new Timer(duration, ()
    {
      if (prefs.getString('id') == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Welcome()),
              (Route<dynamic> route) => false,
        );
      }
      else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BaseScreen()),
              (Route<dynamic> route) => false,
        );
      }
    }
    );}

  initScreen(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              "Lost System",
              style: TextStyle(
                  fontSize:width/12,
                  color: Colors.white
              ),
            ),
            Padding(padding: EdgeInsets.only(top: height/50)),
            FlipLoader(

              iconColor: Colors.white,
              path:"assets/images/print.png",
              animationType: "full_flip",
              rotateIcon: true,
            ),
          ],
        ),
      ),
    );
  }
}
