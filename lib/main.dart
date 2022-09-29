import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/injection_container.dart' as di;
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(App.instance);
}




Future<void> initApp()async{
  await Firebase.initializeApp();
  await di.init();
  Directory root = await getApplicationDocumentsDirectory();
  Hive.init(root.path+ConstantManager.hivePath);
}