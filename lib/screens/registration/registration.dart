import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olxapp/model/user_response.dart';
import 'package:olxapp/screens/flipLoader/flip.dart';
import 'package:olxapp/screens/home/home.dart';
import 'package:olxapp/services/auth.dart';
import 'package:olxapp/services/firebase.dart';
import 'package:olxapp/utilis/space.dart';
import 'package:olxapp/utilis/validate.dart';
import 'package:olxapp/widgets/circular_progress.dart';
import 'package:olxapp/widgets/dialog.dart';
import 'package:olxapp/widgets/rounded_button.dart';
import 'package:olxapp/widgets/rounded_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../baseScreen/base_screen.dart';
import '../loading_bloc.dart';
import '../login/login_bloc.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Registration")),

      ),
      body: Stack(children: <Widget>[
         Container(
          padding: EdgeInsets.only(top:Space().getHeight(context)/10 ),
            child: Form(
                key: _formKey,
                child: ListView(children: <Widget>[
                  FlipLoader(

                    iconColor: Colors.white,
                    path:"assets/images/print.png",
                    animationType: "full_flip",
                    rotateIcon: true,
                  ),
                  SizedBox(height: Space().getHeight(context)/20,),
                  RoundedForm(controller:_userController,hint:"Username",icon:Icon(Icons.supervised_user_circle),msg:"please enter username"),
                  RoundedForm(controller:_emailController,hint:"Email",icon:Icon(Icons.email),msg:"please enter email",validate:validation.emailValidator,),
                  RoundedForm(controller:_phoneController,hint:"Phone",icon:Icon(Icons.phone),msg:"please enter phone"),
                  RoundedForm(controller:_passController,hint:"Password",icon:Icon(Icons.lock),msg:"please enter password",validate:validation.passValidator),
                  Consumer<LoginBloc>(
                      builder: (BuildContext context, LoginBloc bloc) {
                        return RoundedButton(backgroundColor:  Color.fromRGBO(137, 14, 79, 1),buttonText: "Register",textColor: Colors.white,onPressed:()=>validate(bloc),);


                      }),
                  SizedBox(height: Space().getHeight(context)/35,),
                  Center(
                    child: InkWell(child: Text("Already Have Account?",style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: Space().getWidth(context)/20,

                    ),),
                      onTap: (){
                        Navigator.pushNamed(context, "/login");

                      },),
                  )
                ])



            )
        ),
        Consumer<LoginBloc>(

            builder: (BuildContext context, LoginBloc bloc) {
              return Center(child: Offstage(
                  offstage:bloc.loading ,



                  child: Progress(Colors.white)));}
        ),
      ]
      )
    );
  }
  validate(bloc)async{
    bloc.changeLoading(false);

      var userResponse=UserResponse(email: _emailController.text,pass: _passController.text,phone: _phoneController.text,username: _userController.text,imageProfile: "");

      await bloc.createUser(_formKey,userResponse );
      if(bloc.validateSign){
        final prefs =  await SharedPreferences.getInstance();
        prefs.setString('id', bloc.user.uid);


        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BaseScreen()),
              (Route<dynamic> route) => false,
        );
        bloc.changeLoading(true);
      }
      else{
     MakeDialog(msg:"The email already exists",context: context,title: "invalid").buildDialog();
     bloc.changeLoading(true);
      }



    }



}
