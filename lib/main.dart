import 'package:flutter/material.dart';
import 'package:friends/injection_container.dart' as di;

import 'core/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(App.instance);
}

