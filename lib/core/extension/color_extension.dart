


import 'package:flutter/widgets.dart';

extension ColorExtension on Color{

  Map<String,int> toMap(){
    return {
      "r":red,
      "b":blue,
      "g":green,
    };
  }


}