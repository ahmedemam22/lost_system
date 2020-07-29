import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:olxapp/model/post_response.dart';
import 'package:olxapp/model/user_response.dart';
import 'package:olxapp/screens/profile/profile_bloc.dart';
import 'package:olxapp/services/auth.dart';
import 'package:path/path.dart';
class PhotoServices{
  final db = Firestore.instance;
  String ur;


  Future uploadFile(image) async {
    var now = new DateTime.now();
    var rng = new Random();
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('myPostImage$now.${rng.nextInt(100000000)}.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {

      print("$fileURL ddddddddddddd");
      ur=fileURL;
      return fileURL;



    });

return ur;

  }
  Future storeData(PostResponse postResponse)async{
    await db.collection('post').add({'time':postResponse.time,'title': postResponse.title,'description':postResponse.description,'location':postResponse.location
      ,'phone':postResponse.phone,'imagepath':postResponse.imagepath,'id':postResponse.id,'find':postResponse.find});
  }
  Future userData(UserResponse userResponse,id)async{
    await db.collection('users').document(id)
        .setData({'username':userResponse.username,'email':userResponse.email,'phone':userResponse.phone,'pass':userResponse.pass,
      'imagepath':userResponse.imageProfile

      });


  }


}
PhotoServices firebase=PhotoServices();