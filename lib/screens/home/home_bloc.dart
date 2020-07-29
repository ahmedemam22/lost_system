import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olxapp/services/data.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase{
  final _firestoreController = BehaviorSubject<QuerySnapshot>();
  Stream<QuerySnapshot> get outFirestore => _firestoreController.stream;
  Sink<QuerySnapshot> get inFirestore => _firestoreController.sink;
HomeBloc(){

    db.getPosts("").listen((data) => inFirestore.add(data));
}
onchange(value)async{
  await db.getPosts(value).listen((data) => inFirestore.add(data));




}
  @override
  void dispose() {
    _firestoreController.close();
  }
}