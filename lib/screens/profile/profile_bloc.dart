
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:olxapp/screens/profile/profile.dart';
import 'package:olxapp/services/auth.dart';
import 'package:olxapp/services/firebase.dart';
import 'package:olxapp/services/multiple_picker.dart';
import 'package:olxapp/services/update.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends BlocBase{
  FirebaseUser user;
  File image;
  String url;









  getUser()async{
    user=await auth.currentUser();
    notifyListeners();
    final prefs =  await SharedPreferences.getInstance();

    prefs.setString('id', user.uid);
    return user;


  }
  Future <void> getImage()async {
    image = await multiPicker.chooseFile();

    notifyListeners();
  }
  updateimage()async{
    url= await firebase.uploadFile(image);

    notifyListeners();
    print(url);
    update.updateData(user.uid, url);

  }

}