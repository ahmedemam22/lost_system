import 'package:flutter/material.dart';
import 'package:olxapp/utilis/space.dart';
import 'package:olxapp/widgets/rounded_button.dart';
class Welcome  extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: ImageIcon(new AssetImage("assets/images/print.png",),size:Space().getWidth(context)*.15,color: Colors.white,)),
               SizedBox(height: Space().getHeight(context)/35,),
               Text("Lost System",style: TextStyle(color: Colors.white,
               fontSize:Space().getWidth(context)/12 ),
               ),
              Padding(
                padding: EdgeInsets.only(top: Space().getHeight(context)/5,bottom: Space().getHeight(context)/50),
                  child: RoundedButton(backgroundColor:Color.fromRGBO(137, 14, 79, 1),buttonText:"Sign up",textColor:Colors.white,onPressed: ()=>Navigator.pushNamed(context, '/trainer'),)),
              RoundedButton(backgroundColor:Color.fromRGBO(137, 14, 79, 1),buttonText:"login",textColor:Colors.white,onPressed: ()=>Navigator.pushNamed(context, '/login'),)

            ],
          ),
        ),
      ),
    );
  }
}
