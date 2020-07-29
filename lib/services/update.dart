import 'package:cloud_firestore/cloud_firestore.dart';

class Update{
  Future updateFind(id){
    Firestore.instance
        .collection('post')
        .document(id)
        .updateData({'find': "found" });

  }
  Future updateData(id,imagepath){
    Firestore.instance
        .collection('users')
        .document(id)
        .updateData({'imagepath': imagepath });

  }

}
Update update=Update();