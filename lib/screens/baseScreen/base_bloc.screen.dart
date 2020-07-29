import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BaseBloc extends BlocBase {
  final index=BehaviorSubject<int>.seeded(0);


  StreamSink<int>get indexsink{
    return index.sink;
  }
  ValueObservable<int>get indexstream{
    return index.stream;
  }
  BaseBloc(){



  }
  StreamSink<int> setValue(int index){
    indexsink.add(index);
  }
  void dispose(){
    index.close();
  }


}