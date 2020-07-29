import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olxapp/model/tab_model.dart';
import 'package:olxapp/screens/home/home.dart';
import 'package:olxapp/screens/profile/profile.dart';
import 'package:olxapp/screens/profile/profile_bloc.dart';

import '../post/post.dart';
import 'base_bloc.screen.dart';
class BaseScreen extends StatefulWidget {
  @override
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> with SingleTickerProviderStateMixin{
  TabController _tabController;
  BaseBloc baseBloc=new BaseBloc();
  ProfileBloc bloc ;
  final List<TabModel>tabing=<TabModel>[
    TabModel(Profile(),Tab(
    icon: Icon(Icons.person),),"Profile"),
    TabModel(Home(),Tab(
      icon: Icon(Icons.home),),"Home"),
    TabModel(Post(),Tab(
      icon: Icon(Icons.add_comment),),"Post"),

  ];


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
    baseBloc.dispose();
  }
  @override
  void initState() {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
   currentUser == null?
    {Navigator.pushReplacementNamed(context, "/login")}:null});

    _tabController=new TabController(length: 3, vsync: this);



    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(_tabController==null){
      _tabController=new TabController(length: 3, vsync: this);

    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

          return Scaffold(


            bottomNavigationBar: menuBar(),

            body: TabBarView(


              controller: _tabController,

              children: tabing.map(( tab) {



                return tab.screen;
              }).toList(),


            ),

          );







  }

  Widget menuBar(){
    return Container(
      color: Color.fromRGBO(27, 31, 58, 0.5),
      child: TabBar(
        onTap: (index) {
          baseBloc.setValue(index);



        },



        controller: _tabController,

        labelColor: Colors.white,

        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.blue,
        tabs: tabing.map(( tab) {



          return tab.tab;
        }).toList(),

      ),
    );

  }
}

