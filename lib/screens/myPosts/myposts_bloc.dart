import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olxapp/services/data.dart';
import 'package:olxapp/services/update.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPostsBloc extends BlocBase{
  String find="not found";
  final _firestoreController = BehaviorSubject<QuerySnapshot>();
  Stream<QuerySnapshot> get outFirestore => _firestoreController.stream;
  Sink<QuerySnapshot> get inFirestore => _firestoreController.sink;
  MyPostsBloc(){
    getmyPosts();

  }
  changFind(){
    find="found";
    notifyListeners();
  }
  Future getmyPosts()async{
    final prefs =  await SharedPreferences.getInstance();
    db.getmyPosts(prefs.getString('id')).listen((data) => inFirestore.add(data));




  }
  Future updatePosts()async{
    final prefs =  await SharedPreferences.getInstance();
    db.getmyPosts(prefs.getString('id')).listen((data) => inFirestore.add(data));
    notifyListeners();
  }
  deletePost(document)async{
    await db.deletPost(document);
  }
  updateFind(id)async{
    await update.updateFind(id);
  }
}