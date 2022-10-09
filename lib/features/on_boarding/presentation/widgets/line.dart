import 'package:flutter/material.dart';
import 'package:friends/core/manager/color_manager.dart';

class Line extends StatelessWidget {
  const Line({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(20)
        ),
        width: 50,
        height: 5,
        
      ),
    );
  }
}
