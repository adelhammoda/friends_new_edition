

import 'package:flutter/material.dart';
import 'package:friends/core/manager/string_manager.dart';

import 'color_manager.dart';

class ThemeManager{
 static final InputBorder _inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(60),
      borderSide: const BorderSide(
          color: ColorManager.grey,
          width:1,
          style: BorderStyle.solid
      )
  );

static  ThemeData getAllThemeData(){
    return ThemeData(
      colorScheme: ThemeData().colorScheme.copyWith(
        primary: ColorManager.primary,
      ),
        splashColor: ColorManager.black,
        disabledColor: ColorManager.grey,
        focusColor: ColorManager.lightGreen,
        canvasColor: ColorManager.lightGreen,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent)
          )
        ),
        textTheme:  TextTheme(
          labelSmall: TextStyle(
            fontSize: 15,
            fontFamily: AssetsManager.firaCode,
            fontWeight: FontWeight.w400,
            color: ColorManager.black.withOpacity(0.4),

          ) ,
          labelMedium: const TextStyle(
            fontSize: 18,
            fontFamily: AssetsManager.firaCode,
            fontWeight: FontWeight.w400,
            color: ColorManager.black,
          ),
          labelLarge: const TextStyle(
            fontSize: 18,
            fontFamily: AssetsManager.roboto,
            fontWeight: FontWeight.bold,
            color: ColorManager.black
          ),
          displayMedium: TextStyle(
            shadows: [
              Shadow(
                  color: ColorManager.black.withOpacity(0.4),
                  offset: const Offset(0, 6),
                  blurRadius:12,
              ),
            ],
            fontSize:35,
            color:ColorManager.white,
            fontFamily: AssetsManager.firaCode,
            fontWeight: FontWeight.w400,
          ),
          titleLarge: TextStyle(
            fontSize: 60,
            color: ColorManager.black,
            fontFamily: AssetsManager.roboto,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: ColorManager.black.withOpacity(0.4),
                offset: const Offset(0, 8),
                blurRadius: 6
              ),
            ]
          ),
          bodySmall: const TextStyle(
            color: ColorManager.lightGreen,
            fontWeight: FontWeight.w400,
            fontFamily: AssetsManager.firaCode,
            fontSize: 13
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(

          enabledBorder: _inputBorder,
          focusedBorder:_inputBorder ,
          // focusColor: ColorManager.lightGreen,
          fillColor: ColorManager.grey,
          filled: true,
          errorBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(60),
              borderSide: const BorderSide(
                  color: ColorManager.error,
                  width: 1
              )),
          focusedErrorBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(60),
              borderSide: const BorderSide(
                  color: ColorManager.error,
                  width: 2
              )
          ) ,
        ),
        scaffoldBackgroundColor: ColorManager.grey,
        appBarTheme: AppBarTheme(
          shadowColor:ColorManager.white.withOpacity(0),
          backgroundColor: ColorManager.white.withOpacity(0),
          elevation: 0,
        )
    );
  }
}