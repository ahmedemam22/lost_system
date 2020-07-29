import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olxapp/screens/baseScreen/base_screen.dart';
import 'package:olxapp/screens/home/home.dart';
import 'package:olxapp/services/auth.dart';
import 'package:olxapp/utilis/space.dart';
import 'package:olxapp/utilis/validate.dart';
import 'package:olxapp/widgets/dialog.dart';
import 'package:olxapp/widgets/rounded_button.dart';
import 'package:olxapp/widgets/rounded_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../flipLoader/flip.dart';
import 'login_bloc.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    _passController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Login")),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),

        ),
        body: Container(
            padding: EdgeInsets.only(top:Space().getHeight(context)/5 ),
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
                  RoundedForm(controller:_emailController,hint:"Email",icon:Icon(Icons.email),msg:"please enter email",),
                  RoundedForm(controller:_passController,hint:"Password",icon:Icon(Icons.lock),msg:"please enter password",),
                  Consumer<LoginBloc>(

                      builder: (BuildContext context, LoginBloc bloc) {
                        return RoundedButton(backgroundColor: Color.fromRGBO(137, 14, 79, 1),buttonText: "Signin",textColor: Colors.white,onPressed: ()=>validate(bloc),);
                      }),
                  SizedBox(height: Space().getHeight(context)/35,),
                  Center(
                    child: InkWell(child: Text("Create new Account?",style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: Space().getWidth(context)/20,

                    ),),
                      onTap: (){
                        Navigator.pushNamed(context, "/trainer");

                      },),
                  )
                ])



            )
        )
    );
  }

  validate( LoginBloc bloc)async{


    await bloc.signInValidate(_formKey,_emailController.text, _passController.text);
    if(bloc.validate){
      final prefs =  await SharedPreferences.getInstance();
      var user=await auth.currentUser();
      prefs.setString('id', user.uid);
      Navigator.pushNamed(context, "/base");
    }
    else{
      MakeDialog(msg:"check email and password",context: context,title: "invalid email").buildDialog();

    }

  }




}


