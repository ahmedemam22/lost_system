
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
class MultiPicker{

  List<Asset> images = List<Asset>();
  Future<List<Asset>> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 8,
        enableCamera: true,

        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Olx App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    images=resultList;

    return images;



  }
  Future<File> chooseFile() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    return image;


  }





}
MultiPicker multiPicker=MultiPicker();