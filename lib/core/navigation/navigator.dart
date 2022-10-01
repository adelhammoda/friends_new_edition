import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Go extends Navigator {
  const Go._internal();

  static Go get instance => const Go._internal();

  Go.to(BuildContext context, String route, {Key? key,Object? arguments,Bloc? bloc}) : super(key: key) {
    if(bloc==null) {
      Navigator.of(context).pushNamed(route,arguments: arguments);
    }else{

    }
  }

  Go.back(BuildContext context, Key? key) : super(key: key) {
    Navigator.of(context).pop();
  }



}
