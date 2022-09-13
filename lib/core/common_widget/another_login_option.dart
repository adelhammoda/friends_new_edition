import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:responsive_s/responsive_s.dart';

class AnotherLoginOption extends StatelessWidget {
  final void Function() onTap;
  final String image;
  final String content;


  const AnotherLoginOption(
      {Key? key,
      required this.onTap,
      required this.image,
      required this.content,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: responsive.responsiveHeight(forUnInitialDevices: 8),
        width: responsive.responsiveWidth(forUnInitialDevices: 90),
        decoration: BoxDecoration(
            color: ColorManager.grey,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: ColorManager.darkGrey,
            ),
            boxShadow: [
              BoxShadow(
                  color: ColorManager.black.withOpacity(0.1),
                  offset: const Offset(2, 6),
                  blurRadius: 4,
                  spreadRadius: 2),
            ]),
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: SvgPicture.asset(
                  image,
                  width: 30,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                content,
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
