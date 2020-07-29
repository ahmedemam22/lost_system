import 'dart:math';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olxapp/model/post_response.dart';
import 'package:olxapp/screens/post/post_bloc.dart';
import 'package:olxapp/screens/selecImage/select_image.dart';
import 'package:olxapp/widgets/drop_down.dart';
import 'package:olxapp/services/firebase.dart';
import 'package:olxapp/utilis/space.dart';
import 'package:olxapp/widgets/dialog.dart';
import 'package:olxapp/widgets/rounded_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/circular_progress.dart';
class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final _formKey = GlobalKey<FormState>();
  bool visible=true,visible1=false;


  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _locationController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Post")),
      ),
      body: Stack(children: <Widget>[

        Container(
          color: Colors.white,
          child: Form(
              key: _formKey,
              child: ListView(children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DropDown(),

                      textField("Description", "please enter some text",
                          TextInputType.text, 5, Icon(Icons.description),
                          _descriptionController),
                      textField(
                          "Location", "please enter location", TextInputType.text,
                          1, Icon(Icons.location_on), _locationController),
                      textField(
                          "Phone", "please enter phone", TextInputType.phone, 1,
                          Icon(Icons.phone), _phoneController),
                      gallery(),
                      picture(),


                    ]
                  //calling the counter value
                ),

                Align(
                    alignment: Alignment.bottomCenter,
                    child: Consumer<PostBloc>(
                        builder: (BuildContext context, PostBloc bloc) {
                          return RoundedButton(backgroundColor: Colors.grey,buttonText: "Publish",textColor: Colors.black,onPressed: ()=>validate(bloc),);
                        })

                ),
              ],
              )


          ),),

        Consumer<PostBloc>(

            builder: (BuildContext context, PostBloc bloc) {
              return Center(child: Offstage(
                  offstage:bloc.loading ,



                  child: Progress(Colors.indigo)));}
        ),
      ]
      ),
    );
  }


  Widget textField(title, msg, keyboardtype, line, icon, controll) {
    return Padding(
        padding: EdgeInsets.all(Space().getHeight(context)/60),
        child: TextFormField(

          keyboardType: keyboardtype,
          keyboardAppearance: Brightness.dark,
          maxLines: line,

          controller: controll,

          decoration: InputDecoration(
              prefixIcon: icon,


              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(


              ),
              labelText: title


          ),

          validator: (value) {
            if (value.isEmpty) {
              return msg;
            }
            return null;
          },
        ));
  }

  Widget gallery() {
    return Consumer<PostBloc>(
        builder: (BuildContext context, PostBloc bloc) {
          return Padding(
            padding: EdgeInsets.all(Space().getHeight(context)/65),

            child: Row(
              children: <Widget>[
                Text("choose photo", style: TextStyle(
                    fontSize: Space().getWidth(context)/20
                ),),
                SizedBox(width: Space().getWidth(context)/25,),
                FloatingActionButton(
                  child: Icon(Icons.camera_alt),
                  backgroundColor: Colors.purple,
                  onPressed: () async {
                    await bloc.oneImage();
                  },
                )
              ],
            ),


          );
        });
  }

  Widget picture() {
    return Padding(
      padding: EdgeInsets.all(Space().getHeight(context)/60),
      child: Consumer<PostBloc>(builder: (BuildContext context, PostBloc bloc) {
        return bloc.image == null
            ? Container()
            : Image.file(
            bloc.image, width: Space().getWidth(context)*.8, height: Space().getHeight(context)*.2, fit: BoxFit.cover);
      }),
    );
  }

  validate(PostBloc bloc)async {
    bloc.change(false);



    if (_formKey.currentState.validate()) {


      if (bloc.image == null) {
        bloc.change(true);

        -_buildErrorDialog("Please choose a photo!");


      }
      else {
        final prefs = await SharedPreferences.getInstance();
        await bloc.imageUrl();
        firebase.storeData(PostResponse(time:new DateTime.now().toString(),
            title: bloc.dropDown,
            description: _descriptionController.text,
            location:_locationController.text,
            phone:  _phoneController.text, imagepath:bloc.url,id: prefs.getString('id') ?? ''));


        bloc.change(true);

        MakeDialog(msg: "your post was published successful",context: context,title: "Success").buildDialog();

      }
    }






  }
  _buildErrorDialog(msg) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }

}