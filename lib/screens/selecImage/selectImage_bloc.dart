import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:olxapp/services/multiple_picker.dart';

class SelectImagesBloc extends BlocBase{
  List<Asset> images = List<Asset>();
  Future <void> selecting()async{
    images=await multiPicker.loadAssets() ;
    notifyListeners();
  }

}