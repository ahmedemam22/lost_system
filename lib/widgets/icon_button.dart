import 'package:flutter/material.dart';
class Iconbutton extends StatelessWidget {
  Function onpressed;
  Color color;
  Icon icon;


  Iconbutton({this.onpressed,this.color,this.icon});
  @override
  Widget build(BuildContext context) {
    return IconButton(icon: icon,
      color: color,

      onPressed: onpressed,
    );
  }
}
