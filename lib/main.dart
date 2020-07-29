import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:olxapp/model/post_response.dart';
import 'package:olxapp/screens/baseScreen/base_bloc.screen.dart';
import 'package:olxapp/screens/baseScreen/base_screen.dart';
import 'package:olxapp/screens/home/home.dart';
import 'package:olxapp/screens/home/home_bloc.dart';
import 'package:olxapp/screens/login/login.dart';
import 'package:olxapp/screens/login/login_bloc.dart';
import 'package:olxapp/screens/myPosts/myPosts.dart';
import 'package:olxapp/screens/myPosts/myposts_bloc.dart';
import 'package:olxapp/screens/post/post.dart';
import 'package:olxapp/screens/profile/profile.dart';
import 'package:olxapp/screens/profile/profile_bloc.dart';
import 'package:olxapp/screens/post/post_bloc.dart';
import 'package:olxapp/screens/selecImage/selectImage_bloc.dart';
import 'package:olxapp/widgets/splash_screen.dart';
import 'package:olxapp/widgets/drop_down.dart';
import 'package:olxapp/screens/registration/registration.dart';
import 'package:olxapp/screens/welcome.dart';
import 'package:olxapp/utilis/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocs: [
        Bloc((i) => BaseBloc()),
        Bloc((i) => PostBloc()),
        Bloc((i) => SelectImagesBloc()),
        Bloc((i) => PostResponse()),

        Bloc((i) => HomeBloc()),
        Bloc((i) => LoginBloc()),
        Bloc((i) => ProfileBloc()),
          Bloc((i) => MyPostsBloc()),


        ],
      child:MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: myTheme,
         initialRoute: "/splash",
          routes: <String, WidgetBuilder>{
            '/welcome': (BuildContext context) => Welcome(),
            '/fire': (BuildContext context) => DropDown(),
            '/splash': (BuildContext context) => Splash(),
            '/home': (BuildContext context) => Home(),
            '/trainer': (BuildContext context) => Registration(),
            '/login': (BuildContext context) => Login(),
            '/profile': (BuildContext context) => Profile(),
            '/base': (BuildContext context) => BaseScreen(),
            '/myposts': (BuildContext context) => MyPosts(),
            '/post': (BuildContext context) => Post(),

          })
         //Navigator.pushReplacementNamed(context, "/login") ttktb henak
    );
  }
}
