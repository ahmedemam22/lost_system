import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olxapp/screens/profile/profile_bloc.dart';
import 'package:olxapp/screens/selecImage/select_image.dart';
import 'package:olxapp/utilis/space.dart';
import 'package:olxapp/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/circular_progress.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final bloc = BlocProvider.getBloc<ProfileBloc>();



  @override
  void initState() {
    bloc.getUser();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Profile")),

      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: EdgeInsets.only(top: Space().getHeight(context)/10),
        child: Consumer<ProfileBloc>(builder: (BuildContext context, ProfileBloc bloc) {

          return FutureBuilder(
              future: Firestore.instance.collection('users').document(bloc.user.uid)
                  .get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(!snapshot.hasData){
                  return Progress(Colors.white);
                }


                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: Space().getWidth(context)*.25,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: new SizedBox(
                                  width: Space().getWidth(context)*.45,
                                  height: Space().getWidth(context)*.45,
                                  child: snapshot.data['imagepath']== "" ? Container():Image.network(
                                    snapshot.data['imagepath'],
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null)
                                        return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.grey,
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                              : null,
                                        ),
                                      );
                                    },

                                  )
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Space().getHeight(context)/10),
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: Space().getWidth(context)/10,
                            ),
                            onPressed: () async{

                              await bloc.getImage();
                              if(bloc.image!=null){
                                await bloc.updateimage();

                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Space().getHeight(context)/35,),
                    Text(snapshot.data["username"],
                        style: TextStyle(
                            color: Colors.white, fontSize: Space().getWidth(context)/15
                            ,fontWeight: FontWeight.bold
                        )),


                    item(snapshot.data['phone']),


                  ],);
              });





        } )

        ,
      ),
    );

  }
  Widget item(title){
    return Column(
        children: <Widget>[
          SizedBox(height: Space().getHeight(context)/50,),
          Text(title,
            style: TextStyle(
              color: Colors.white, fontSize: Space().getWidth(context)/15,
            ),
          )]);

  }




}
