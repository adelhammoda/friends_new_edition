



import 'dart:ui';

extension MapExtension on Map{
  Color toColor({double opacity =1}){
    return Color.fromRGBO(this['r']??255, this['g']??255, this['b']??255, opacity);
  }
}