import 'package:bloc_pattern/bloc_pattern.dart';

class LoadingBloc extends BlocBase{
  bool loading=true;
  change(bool value){
    loading=value;
    notifyListeners();
  }
}