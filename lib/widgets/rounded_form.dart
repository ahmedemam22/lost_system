import 'package:flutter/material.dart';
import 'package:olxapp/services/data.dart';
class RoundedForm extends StatefulWidget {
  String hint;
  Icon icon;
  TextEditingController controller;
  String msg;
  Function validate;
  Function onchange;


  RoundedForm({this.controller,this.hint,this.icon,this.msg,this.validate,this.onchange});

  @override
  _RoundedFormState createState() => _RoundedFormState();
}

class _RoundedFormState extends State<RoundedForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: new TextFormField(
        controller: widget.controller,
        keyboardType: widget.hint=="Phone"?TextInputType.phone:TextInputType.text,

        decoration: new InputDecoration(

          prefixIcon: widget.icon,
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0),
              ),

            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[800]),
            hintText: widget.hint,
            focusColor: Colors.blue,

            fillColor: Colors.white70),
        validator: widget.validate==null?(value) {
          if (value.isEmpty) {
            return widget.msg;
          }
          return null;
        }:widget.validate,
        onChanged: widget.onchange

        ,

      ),
    );
  }
}
