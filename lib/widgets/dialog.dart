import 'package:flutter/material.dart';
class MakeDialog {
  String msg;
String title;
BuildContext context;
Function onpressed;

  MakeDialog({this.msg,this.context,this.title,this.onpressed});
  buildDialog(){
    return showDialog(
      builder: (context) {
        return AlertDialog(
          content: Text(msg),
          title: Text(title),
          actions: <Widget>[
            FlatButton(
                child: Text('Ok'),
                onPressed: onpressed==null?() {
                  Navigator.of(context).pop();

                }:()async{
                  await onpressed;
                  Navigator.of(context).pop();

                })
          ],
        );
      },
      context: context,
    );
  }
  buildDialog1(){
    showDialog(
      builder: (context) {
        return AlertDialog(
          content: Text(msg),
          title: Text(title),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();

                }),
            FlatButton(
                child: Text('Ok'),
                onPressed: onpressed,

      )
          ],
        );
      },
      context: context,
    );

  }


}









