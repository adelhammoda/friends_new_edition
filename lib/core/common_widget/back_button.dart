import 'package:flutter/material.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/size_manager.dart';
import 'package:responsive_s/responsive_s.dart';

class FriendsBackButton extends StatelessWidget {
  const FriendsBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Padding(
      padding: EdgeInsets.all(responsive.responsiveWidth(forUnInitialDevices: 4)),
      child: Container(
        alignment: Alignment.center,
        decoration:  BoxDecoration(
          border: Border.all(
            color: ColorManager.grey,
            width: SizeManager.s2
          ),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          iconSize:responsive.responsiveWidth(forUnInitialDevices:4),
          padding: EdgeInsets.zero,
            alignment: Alignment.center,
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
      ),
    );
  }
}
