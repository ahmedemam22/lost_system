import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:olxapp/screens/home/home.dart';
import 'package:olxapp/screens/myPosts/myposts_bloc.dart';
import 'package:olxapp/screens/profile/profile_bloc.dart';
import 'package:olxapp/screens/welcome.dart';
import 'package:olxapp/services/auth.dart';
import 'package:olxapp/utilis/space.dart';
import 'package:olxapp/widgets/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
MakeDialog dialog;

      return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
        Consumer<ProfileBloc>(builder: (BuildContext context, ProfileBloc bloc) {

            return UserAccountsDrawerHeader(
              accountName: text(bloc.user.email, context),
            );}),
    Consumer<MyPostsBloc>(builder: (BuildContext context, MyPostsBloc bloc) {


     return ListTile(
              title: text("My Posts",context),
              trailing:Icon(Icons.comment),
              onTap: ()async {
                await bloc.getmyPosts();
                Navigator.pushNamed(context, '/myposts');
              },
            );}),
            ListTile(
              title: text("Contact Us",context),
              trailing:Icon(Icons.contact_mail),
              onTap: () {
                dialog=MakeDialog(title:"Contact Us",msg:"For any suggestions or complaints contact us by Email: olx@gmail.com.",context:context);
                dialog.buildDialog();

              },
            ),
            ListTile(
              title: text("About App",context),
              trailing:Icon(Icons.info),
              onTap: () {
                dialog=MakeDialog(title:"About App",msg:"Olx Serves anyone who has lost something and wants to find it.",context:context);
                dialog.buildDialog();
              },
            ),
            ListTile(
              title: text("Logout", context),
              trailing: Icon(Icons.exit_to_app),
              onTap: () async{
                await auth.signOut();
                final prefs =  await SharedPreferences.getInstance();
                prefs.setString('id',null);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Welcome()),
                      (Route<dynamic> route) => false,
                );
                // Navigator.pushNamed(context, '/welcome');
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      );


  }
  Widget text(title,context){
    return Text(title
      ,style: TextStyle(
          fontSize: Space().getWidth(context)/20
      ),);

  }

}
