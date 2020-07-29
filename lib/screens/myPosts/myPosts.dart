import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olxapp/model/post_response.dart';
import 'package:olxapp/screens/myPosts/myposts_bloc.dart';
import 'package:olxapp/utilis/space.dart';
import 'package:olxapp/widgets/card_shape.dart';

class MyPosts extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<MyPostsBloc>();
    return Scaffold(
      appBar: AppBar(
          title:Center(child: Text("MyPosts"))),
      body: StreamBuilder(
          stream: bloc.outFirestore,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(!snapshot.hasData||snapshot.data.documents.length==0) {
              return Center(child: Text("Not Found!",style: TextStyle(
                  fontSize: Space().getWidth(context)/15,
                  color: Colors.white
              ),));
            }
            return Column(children: <Widget>[



              Expanded(
                child: Container(
                  height:MediaQuery.of(context).size.height,
                  child: ListView.builder(itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {


                      return CardShape(postResponse:PostResponse.fromJson(snapshot.data.documents[index]),type: "myposts",
                        onpressed: ()=>
                            _buildErrorDialog("Are You want to delete this post?", context, bloc, snapshot.data.documents[index].documentID),onpressed1:
                            ()=>_buildErrorDialog1(context, bloc, snapshot.data.documents[index].documentID),);






                    },),
                ),
              ),

            ]);
          }),
    );
  }
  _buildErrorDialog(msg,context,MyPostsBloc bloc, document) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: (){

                  Navigator.of(context).pop();
                }),
            FlatButton(
                child: Text('Ok'),
                onPressed: () async{
                  await bloc.deletePost(document);
                  await bloc.updatePosts();
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
  _buildErrorDialog1(context,MyPostsBloc bloc, document) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          content: Text("Have you found lost"),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: (){

                  Navigator.of(context).pop();
                }),
            FlatButton(
                child: Text('Ok'),
                onPressed: () async{
                  await bloc.updateFind(document);

                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}

