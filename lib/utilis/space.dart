import 'package:flutter/cupertino.dart';

class Space{

  double getHeight(BuildContext context){
    return MediaQuery.of(context).size.height;

  }
  double getWidth(BuildContext context){
    return MediaQuery.of(context).size.width;

  }
}