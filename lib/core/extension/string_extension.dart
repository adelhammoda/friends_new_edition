







import 'package:flutter/widgets.dart';
import 'package:friends/core/exception/exception.dart';

extension StringEx on String{


  DateTime toDateTime(){
   return DateTime.parse(this);
  }

  double toDouble({bool canBeNull = false}){
   double? res =  double.tryParse(this);
   if(res == null && !canBeNull){
     debugPrint('to double extension');
     throw BadFormatException();
   }else if(res == null && canBeNull){
     return 0.0;
   }else {
     return res!;
   }
  }
  int? toInt({bool canBeNull = false}){
    int? res =  int.tryParse(this);
    if(res == null && canBeNull){
      debugPrint('$this to int extension');
      return null;
    }else if(res == null && canBeNull){
      return 0;
  } else{
      return res!;
    }
  }


}