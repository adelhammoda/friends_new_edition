

import 'package:flutter/material.dart';

class  ColorManager{

  static  Color white=const Color(0xFFFFFFFF);
  static  Color grey=const Color(0xFFF5F5F5);
  static  Color black=const Color(0xFF030303);
  static const Color lightGreen = Color(0xFF00FF78);
  static const Color darkGreen = Color(0xFF20DB78);
  static const Color error = Color(0xffE81919);
  static const Color importantText = Color(0xFFFF0101);
  static const Color red = Color(0xFFFF0000);
  static  Color primary =const Color(0xff20DB78);
  static const Color darkGrey = Color(0xff707070);
  static const Color drawerColor = Color(0xff323940);
  static const Color favoriteColor = Color(0xFFFFE600);
  static const Color bellColor = Color(0xFFFABE7C);
  static switchToDark(){
    grey =const Color(0xff191923);
    black = white;
    white = const Color(0xFFF5F5F5);
  }
  static switchToLight(){
    grey=const Color(0xFFF5F5F5);
    white=const Color(0xFFFFFFFF);
    black=const Color(0xFF030303);
  }
}