import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_bloc/setting_bloc/setting_bloc.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/injection_container.dart' as di;
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:friends/core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initApp();
  runApp(BlocProvider<SettingBloc>(
    child: App.instance,
    create: (context) => di.sl<SettingBloc>(),
  ));
}

Future<void> initApp() async {
  await Firebase.initializeApp();
  di.init();
  Directory root = await getApplicationDocumentsDirectory();
  Hive.init(root.path + ConstantManager.hivePath);
}
