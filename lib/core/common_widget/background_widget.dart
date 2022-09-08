
import 'package:flutter/material.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:responsive_s/responsive_s.dart';

class FriendsBackgroundWidget extends StatelessWidget {
  final Widget? child;
  const FriendsBackgroundWidget({Key? key,this.child,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive=Responsive(context);
    return Container(
      width: responsive.responsiveWidth(forUnInitialDevices: 100),
      height: responsive.responsiveHeight(forUnInitialDevices: 100),
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            AssetsManager.background,
          ),
          fit: BoxFit.fill
        )
      ),
      child: ClipPath(
         clipper: BackgroundClipper(),
        child: Container(
          decoration: const BoxDecoration(
            color:ColorManager.grey,
          ),
          width: responsive.responsiveWidth(forUnInitialDevices: 100),
          height: responsive.responsiveHeight(forUnInitialDevices: 80),
          child: child,
          // child: child,
        ),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path>{
  BackgroundClipper():super();
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.addArc(Rect.fromCenter(center: Offset(size.width/2,0), width: size.width, height: size.height*0.7), 0,100);
    p.moveTo(0, 0);
    p.lineTo(0, size.height);
    p.lineTo(size.width,size.height);
    p.lineTo(size.height, 0);
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => oldClipper!=this;


}
