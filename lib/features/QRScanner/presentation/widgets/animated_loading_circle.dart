import 'package:flutter/material.dart';
import 'package:friends/core/manager/color_manager.dart';

class AnimatedLoadingCircle extends StatefulWidget {
  final double radius;

  const AnimatedLoadingCircle({Key? key, required this.radius})
      : super(key: key);

  @override
  State<AnimatedLoadingCircle> createState() => _AnimatedLoadingCircleState();
}

class _AnimatedLoadingCircleState extends State<AnimatedLoadingCircle>
    with SingleTickerProviderStateMixin {
  late final Animation<double> alignmentGradient;
  late final AnimationController controller;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    alignmentGradient = Tween(end: 2.0, begin: -0.5).animate(controller);
    controller.repeat(reverse: true);
  }

  @override
  dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: alignmentGradient,
        builder: (c, w) {
          return Container(
            width: widget.radius,
            height: widget.radius,
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                  begin:  const Alignment(-1, -1),
                  end: Alignment(alignmentGradient.value,alignmentGradient.value),
                  colors: [
                    ColorManager.darkGrey.withOpacity(0.4),
                    ColorManager.darkGrey.withOpacity(0.5),
                    ColorManager.darkGrey.withOpacity(0.4),
                  ]),
              color: ColorManager.darkGrey,
              shape: BoxShape.circle,
            ),
          );
        });
  }
}
