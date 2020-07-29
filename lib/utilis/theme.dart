import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
Map<int, Color> color ={50:Color.fromRGBO(136,14,79, .1),100:Color.fromRGBO(136,14,79, .2),200:Color.fromRGBO(136,14,79, .3),300:Color.fromRGBO(136,14,79, .4),400:Color.fromRGBO(136,14,79, .5),500:Color.fromRGBO(136,14,79, .6),600:Color.fromRGBO(136,14,79, .7),700:Color.fromRGBO(136,14,79, .8),800:Color.fromRGBO(136,14,79, .9),900:Color.fromRGBO(136,14,79, 1),};
MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);
ThemeData myTheme=ThemeData(


  primarySwatch: colorCustom,
  accentColor: Color.fromRGBO(35, 40, 77, 0.2),
  cardTheme: CardTheme(
    color: Color.fromRGBO(35, 40, 77, 0.4)
  ),

  scaffoldBackgroundColor:Color.fromRGBO(35, 40, 77, 0.4),




);