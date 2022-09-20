import 'package:flutter/material.dart';


class Go extends Navigator {
  const Go._internal();

  static Go get instance => const Go._internal();

  Go.to(BuildContext context, String route, {Key? key}) : super(key: key) {
    Navigator.of(context).pushNamed(route);
  }

  Go.back(BuildContext context, Widget page, Key? key) : super(key: key) {
    Navigator.of(context).pop();
  }



}
