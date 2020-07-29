import 'package:flutter/material.dart';
class Progress extends StatelessWidget {
 var color;
  Progress(this.color);
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(
      backgroundColor: color,
    ));
  }
}
