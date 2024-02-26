


import 'package:flutter/widgets.dart';

extension ConvertList on List<Object?>?{

  List<Map>? convertToListOfMap(){
    List<Map> l = [];
    if(this == null){
      return null;
    }else {
      for (var item in this!) {
        if (item is Map) {
          l.add(item);
        } else {
          debugPrint("Format exception  convert list to list of map");
          throw const FormatException();
        }
      }
    }
    return l;
  }


  List<String> toListOfString(){
    List<String> res = [];
    if(this == null){
      return [];
    }else{
      for(var item in this!){
        if(item is String) {
          res.add(item);
        }else {
          debugPrint("Format exception convert list to list of string");
          // throw const FormatException();
        }
      }
    }
    return res;
  }

}