







import 'package:friends/core/exception/exception.dart';

extension stringEx on String{


  DateTime toDateTime(){
   return DateTime.parse(this);
  }

  double toDouble(){
   double? res =  double.tryParse(this);
   if(res == null){
     throw BadFormatException();
   }else {
     return res;
   }
  }
  int toInt(){
    int? res =  int.tryParse(this);
    if(res == null){
      throw BadFormatException();
    }else {
      return res;
    }
  }


}