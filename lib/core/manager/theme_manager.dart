

import 'package:flutter/material.dart';
import 'package:friends/core/manager/font_manager.dart';
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
        splashColor: ColorManager.lightGreen,
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
            fontSize:FontManager.fontSizeMedium,
            fontFamily: AssetsManager.firaCode,
            fontWeight: FontWeight.w400,
            color: ColorManager.black.withOpacity(0.4),
          ) ,
          labelMedium: const TextStyle(
            fontSize: FontManager.fontSizeMediumPlus,
            fontFamily: AssetsManager.firaCode,
            fontWeight: FontWeight.w400,
            color: ColorManager.black,
          ),
          labelLarge: const TextStyle(
            fontSize: FontManager.fontSizeMediumPlus,
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
            fontSize:FontManager.fontSizeLargeLabel,
            color:ColorManager.white,
            fontFamily: AssetsManager.firaCode,
            fontWeight: FontWeight.w400,
          ),
          titleMedium: const TextStyle(
            fontSize: FontManager.fontSizeLarge,
            color: ColorManager.white,
            fontFamily: AssetsManager.roboto,
            fontWeight: FontWeight.bold
          ),
          titleLarge: TextStyle(
            fontSize: FontManager.fontSizeBigTitle,
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
          titleMedium: const TextStyle(
              fontSize: 20,
              color: ColorManager.black,
              fontFamily: AssetsManager.firaCode,
              fontWeight: FontWeight.w400
          ),
          titleSmall:  const TextStyle(
              fontSize: 18,
              color: ColorManager.white,
              fontFamily: AssetsManager.roboto,
              fontWeight: FontWeight.w500
          ),
          bodySmall: const TextStyle(
            color: ColorManager.lightGreen,
            fontWeight: FontWeight.w400,
            fontFamily: AssetsManager.firaCode,
            fontSize: FontManager.fontSizeSmallBody
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
          iconTheme: const IconThemeData(
            color: ColorManager.black
          )
        ),
      drawerTheme: DrawerThemeData(
        backgroundColor: ColorManager.drawerColor,
        elevation: 10,
        scrimColor: ColorManager.white.withOpacity(0.5)
      ),
    );
  }
}