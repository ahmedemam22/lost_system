import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:olxapp/model/user_response.dart';
import 'package:olxapp/services/auth.dart';
import 'package:olxapp/services/firebase.dart';

class LoginBloc extends BlocBase{
  bool validate=false;
  bool validateSign=false;
  String userId;
  String idResgister;
  FirebaseUser user;
  bool loading=true;
  changeLoading(value){
    loading=value;
    notifyListeners();
  }

  LoginBloc(){

  }
  Future<bool> signInValidate(GlobalKey<FormState> formKey,email,pass)async{
    if (formKey.currentState.validate()) {
      try {
        await auth.signIn(email, pass);
      } catch(signInError) {
        if(signInError is PlatformException) {

            validate=false;
            notifyListeners();
            return false;


        }

      }
      validate=true;
      notifyListeners();
      return true;
    }
  }


  Future<bool> registerValidate(GlobalKey<FormState> formKey,email,pass)async{
    if (formKey.currentState.validate()) {
      try {
        idResgister=await auth.createUser(email, pass);

        notifyListeners();

      } catch(signUpError) {
        if(signUpError is PlatformException) {
          if(signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
            return false;

          }
        }

      }
      return true;
    }
  }
  createUser(GlobalKey<FormState> formKey,UserResponse userResponse)async{
    validateSign= await registerValidate(formKey, userResponse.email, userResponse.pass);
    notifyListeners();
    if(validateSign){
      user=await auth.currentUser();
      notifyListeners();
      await firebase.userData(userResponse,user.uid);


    }
  }



}
