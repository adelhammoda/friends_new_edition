

import 'package:flutter/material.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:120,
        height: 120,
        child: Lottie.asset(AssetsManager.loader));
  }
}
