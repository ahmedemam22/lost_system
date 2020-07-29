import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olxapp/screens/home/home_bloc.dart';

class GetData{

  final db=Firestore.instance;

  Stream<QuerySnapshot>getPosts(value){
    if (value==""){
      return db.collection("post").orderBy("time",descending: true).snapshots();
    }
    else{
      return    db.collection("post").orderBy("time",descending: true).where("title",isEqualTo: value).snapshots();
    }



  }
  Stream<DocumentSnapshot>getUserdata(id){

    return Firestore.instance.collection('users').document(id).snapshots();





  }
  Stream <QuerySnapshot>getmyPosts(id){
    return    db.collection("post").orderBy("time",descending: true).where("id",isEqualTo: id).snapshots();

  }
  deletPost(document)async{
   await db
        .collection('post')
        .document(document)
        .delete();
  }
}
GetData db=GetData();
