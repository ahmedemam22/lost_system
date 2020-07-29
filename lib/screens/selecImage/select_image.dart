
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:olxapp/screens/selecImage/selectImage_bloc.dart';
import 'package:path/path.dart';
class SelectImage extends StatefulWidget {
  @override
  _SelectImageState createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {

 



  @override
  Widget build(BuildContext context) {
    return
      new Scaffold(
        appBar: new AppBar(
          title: Center(child: const Text('Photos')),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[




      Container(
          child:Consumer<SelectImagesBloc>(
              builder: (BuildContext context, SelectImagesBloc bloc) {



         return RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.red)
          ),
          child: Text("Pick images"),
          onPressed: (){bloc.selecting();},
        );
              }
      ),
        width: 250,
        height: 40,

                ),


              Expanded(
                child: buildGridView(),
              ),

            ],
          ),
        ),
      );

  }
  Widget buildGridView() {
    return Consumer<SelectImagesBloc>(
        builder: (BuildContext context, SelectImagesBloc bloc) {

       return Column(
         children: <Widget>[
         Expanded(
           child: GridView.count(
            padding: EdgeInsets.all(10),
            crossAxisCount: 3,
            children: List.generate(bloc.images.length, (index) {
              Asset asset = bloc.images[index];


              return AssetThumb(
                asset: asset,
                width: 300,
                height: 300,

              );
            }),
      ),
         ),
           Expanded(child:
           RaisedButton(child: Text("ok")
             ,onPressed: (){
             //uploadFile(image);
             },))
         ],
       );
        }
       );


  }
  Future uploadFile(image) async {
    String fileName = basename(image.path);
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child(fileName);
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {

    });
  }

}