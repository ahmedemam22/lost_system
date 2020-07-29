import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olxapp/screens/post/post_bloc.dart';

class DropDown extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<DropDown> {



  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

return  Container(
  color: Colors.grey,
  child:   Consumer<PostBloc>(
    builder: (BuildContext context, PostBloc bloc) {
      return DropDownFormField(

        titleText: 'Title',
        hintText: 'Please choose one',

        value: bloc.dropDown,
        onSaved: (value) {

            bloc.dropValue(value);

        },
        onChanged: (value) {

          bloc.dropValue(value);


        },
        dataSource: [
          {
            "display": "Mobile",
            "value": "mobile",
          },
          {
            "display": "Laptob",
            "value": "laptob",
          },
          {
            "display": "Money",
            "value": "Money",
          },
          {
            "display": "Wallet",
            "value": "wallet",
          },
          {
            "display": "Papers",
            "value": "papers",
          },
          {
            "display": "Key",
            "value": "key",
          },
          {
            "display": "Others",
            "value": "others",
          },
        ],
        textField: 'display',
        valueField: 'value',
      );
    }
  ),
);




  }
}
