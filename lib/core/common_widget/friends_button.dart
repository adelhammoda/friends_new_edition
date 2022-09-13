import 'package:flutter/material.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:responsive_s/responsive_s.dart';

class FriendsButton extends StatefulWidget {
  final Function()? onPressed;
  final Widget? child;

  const FriendsButton({Key? key, this.child, this.onPressed}) : super(key: key);

  @override
  State<FriendsButton> createState() => _FriendsButtonState();
}

class _FriendsButtonState extends State<FriendsButton> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTapDown: (TapDownDetails tapDownDetails) {
          setState(() {
            clicked = true;
          });
        },
        onTapUp: (tapUpDetails) {

          setState(() {
            clicked = false;
          });
        },
        onTapCancel: (){
          setState(() {
            clicked = false;
          });
        },
        onTap: widget.onPressed,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          alignment: Alignment.center,
          width: clicked
              ? responsive.responsiveWidth(forUnInitialDevices: 68.5)
              : responsive.responsiveWidth(forUnInitialDevices: 70),
          height:  responsive.responsiveHeight(forUnInitialDevices: 13),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: ColorManager.black.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 12,
                    offset: const Offset(0, 8))
              ],
              gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [ColorManager.lightGreen, ColorManager.darkGreen]),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                      responsive.responsiveWidth(forUnInitialDevices: 50)),
                  topLeft: Radius.circular(
                      responsive.responsiveWidth(forUnInitialDevices: 20)),
                  bottomLeft: Radius.circular(
                      responsive.responsiveWidth(forUnInitialDevices: 50)),
                  bottomRight: Radius.circular(
                      responsive.responsiveWidth(forUnInitialDevices: 20)))),
          child: widget.child,
        ),
      ),
    );
  }
}
