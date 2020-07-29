import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olxapp/model/post_response.dart';
import 'package:olxapp/widgets/circular_progress.dart';
import 'package:olxapp/services/data.dart';
import 'package:olxapp/widgets/card_shape.dart';
import 'package:olxapp/widgets/rounded_form.dart';

import 'home_bloc.dart';
class Home  extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  TextEditingController _searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<HomeBloc>();
    return Scaffold(
      appBar: AppBar(
          title:Center(child: Text("Home"))),
      body: StreamBuilder(
          stream: bloc.outFirestore,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(!snapshot.hasData) {
              return Progress(Colors.white);
            }
            return Container(
              color: Colors.grey,
              child: Column(children: <Widget>[

                RoundedForm(controller: _searchController,hint:"search",icon: Icon(Icons.search),onchange: bloc.onchange,)
                ,

                Expanded(
                  child: Container(
                    height:MediaQuery.of(context).size.height,
                    child: ListView.builder(itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {

                        return CardShape(postResponse:PostResponse.fromJson(snapshot.data.documents[index]));

                      },),
                  ),
                )]),
            );
          }),
    );
  }

}
