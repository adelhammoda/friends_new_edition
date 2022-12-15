


import 'package:flutter/material.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingLocalDataSource{
  Future<void> switchTheme({required bool isDark});
  Future<void> switchLanguage({required String local});
  Future<String> getLanguage();
  Future<ThemeMode> getTheme();
  Future<void> deleteAccountFromLocalRepository();
}

class SettingLocalDataSourceImpl implements SettingLocalDataSource{
  @override
  Future<void> switchLanguage({required String local}) async{
   final SharedPreferences localStorage= await SharedPreferences.getInstance();
   localStorage.setString(ConstantManager.local, local);
  }

  @override
  Future<void> switchTheme({required bool isDark}) async {
    final SharedPreferences localStorage= await SharedPreferences.getInstance();
    localStorage.setBool(ConstantManager.theme, isDark);
  }

  @override
  Future<String> getLanguage() async{
    final SharedPreferences localStorage= await SharedPreferences.getInstance();
    String? res = localStorage.getString(ConstantManager.local);
    return res??ConstantManager.defaultLanguage;
  }

  @override
  Future<ThemeMode> getTheme() async {
    final SharedPreferences localStorage= await SharedPreferences.getInstance();
    bool? res = localStorage.getBool(ConstantManager.theme);
    if(res == null){
      return ThemeMode.system;
    }else if(res){
      return ThemeMode.dark;
    }else{
      return ThemeMode.light;
    }
  }

  @override
  Future<void> deleteAccountFromLocalRepository() async{
    final storage = await SharedPreferences.getInstance();
    await storage.remove(ConstantManager.cashedEmailAndPasswordKey);
    await storage.remove(ConstantManager.cashedUser);
  }

}