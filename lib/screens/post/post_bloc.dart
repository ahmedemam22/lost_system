

import 'dart:io';
import 'dart:math';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olxapp/model/post_response.dart';
import 'package:olxapp/screens/profile/profile_bloc.dart';
import 'package:olxapp/services/data.dart';
import 'package:olxapp/services/firebase.dart';
import 'package:olxapp/services/multiple_picker.dart';
class PostBloc extends BlocBase{
  File  image;
  String  url;
  bool loading=true;
  String find="not found";
  String dropDown='others';
  dropValue(value){
    dropDown=value;
    notifyListeners();
  }
  change(bool value){
    loading=value;
    notifyListeners();
  }
  changeFound(){
    find="found";
    notifyListeners();
  }


  Future <void> oneImage()async {
    image = await multiPicker.chooseFile();

    notifyListeners();
  }
  Future  imageUrl()async {

    url=await firebase.uploadFile(image);

    notifyListeners();
  }
  Future storeData(time,title,description,location,phone)async {
    await firebase.storeData(PostResponse(time:time,title:title, description:description, location:location, phone:phone,imagepath: url,id: ProfileBloc().user.uid));

  }
  Future uploadFile() async {
    var now = new DateTime.now();
    var rng = new Random();
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('myPostImage$now.${rng.nextInt(100000000)}.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) async{
      url=await fileURL;

      print("$fileURL ddddddddddddd");




    });
    print("mn henaaaaaak$url");
    notifyListeners();


  }
}





