







import 'package:flutter/widgets.dart';
import 'package:friends/core/exception/exception.dart';

extension StringEx on String{


  DateTime toDateTime() {
    return DateTime.parse(this);
  }

  double toDouble({bool canBeNull = false}) {
    double? res = double.tryParse(this);
    if (res == null && !canBeNull) {
      debugPrint('to double extension');
      throw BadFormatException();
    } else if (res == null && canBeNull) {
      return 0.0;
    } else {
      return res!;
    }
  }

  int? toInt({bool canBeNull = false}) {
    int? res = int.tryParse(this);
    if (res == null && canBeNull) {
      return null;
    } else if (res == null && canBeNull) {
      return 0;
    } else {
      return res!;
    }
  }


  String capitalizeTheFirstCharacter(){
    return this[0].toUpperCase()+substring(1);
  }


// String tr(){
//   return AppLocalizations.of(context)?.translate(this)??this;
//
// }

}
extension StringNull on String? {

  bool isNullOrEmpty(){
    if(this == null){
      return true;
    }else if(this!.isEmpty){
      return true;
    }
    else {
      return false;
    }
  }

}