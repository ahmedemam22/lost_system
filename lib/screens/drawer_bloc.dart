import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:olxapp/services/auth.dart';

class DraweBloc extends BlocBase{
  logout()async{
    await auth.signOut();
  }
}