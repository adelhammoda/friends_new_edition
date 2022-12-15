import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:responsive_s/responsive_s.dart';

class FriendsNavigationBar extends StatefulWidget {
  final List<IconData> items;
  final double iconSize;
  final double height;
  final int initialIndex;
  final Function(int index)? onTap;
  const FriendsNavigationBar(
      {Key? key,
      required this.items,
      required this.iconSize,
      required this.height, this.onTap,
      this.initialIndex = 0})
      : super(key: key);

  @override
  State<FriendsNavigationBar> createState() => _FriendsNavigationBarState();
}

class _FriendsNavigationBarState extends State<FriendsNavigationBar> {
  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    final double buttonWidth =
        responsive.responsiveWidth(forUnInitialDevices: 100) /
            widget.items.length;
      widgets.clear();
    for (int i = 0; i < widget.items.length; i++) {
      widgets.add(NVBButton(
        onTap: widget.onTap,
        iconSize: widget.iconSize,
        child: widget.items[i],
        buttonHigh: widget.height,
        buttonWidth: buttonWidth,
        index: i,
        initialIndex: widget.initialIndex,
      ));
    }
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: widgets,
        ),
    );
  }
}

class NVBButton extends StatefulWidget {
  final double buttonWidth;
  final double buttonHigh;
  final Color? buttonColor;
  final IconData child;
  final Function(int index)? onTap;
  final Duration duration;
  final Color iconActiveColor;
  final Color? iconDisabledColor;
  final int index;
  final double iconSize;
  final int initialIndex;
  const NVBButton(
      {Key? key,
      required this.buttonWidth,
      required this.buttonHigh,
      this.buttonColor,
      required this.child,
      this.onTap,
      this.duration = const Duration(milliseconds: 200),
      this.iconActiveColor = ColorManager.lightGreen,
      this.iconDisabledColor,
      required this.index,
      required this.iconSize,  this.initialIndex =0})
      : super(key: key);

  @override
  State<NVBButton> createState() => _NVBButtonState();
}

class _NVBButtonState extends State<NVBButton> {


  @override
  initState(){
    super.initState();
    BlocProvider.of<NavigationBarBloc>(context)
        .add(Animate(widget.initialIndex));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: widget.buttonWidth,
      child: BlocBuilder<NavigationBarBloc, NavigationBarState>(
        builder: (context, state) {
          if (state is AnimateState) {
            return Listener(
              onPointerUp: (_) {
                widget.onTap?.call(widget.index);
                BlocProvider.of<NavigationBarBloc>(context)
                    .add(Animate(widget.index));
              },
              child: Stack(
                clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  fit: StackFit.loose,
                  children: <Widget>[
                    Container(
                      decoration:  BoxDecoration(
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                              color: ColorManager.grey,
                              blurRadius: 1,
                              spreadRadius: 0,
                              offset: const Offset(0, -1),
                              blurStyle: BlurStyle.inner),
                        ],
                      ),
                      child: ClipPath(
                        clipper: _ButtonClipper(
                          widgetHeight: widget.buttonHigh,
                            halfContainerWidth: 25,
                            animate: state.index == widget.index),
                        child: Container(
                          decoration:  BoxDecoration(
                            color: ColorManager.white,
                          ),
                          width: widget.buttonWidth,
                          height: widget.buttonHigh/2,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      top: state.index == widget.index
                          ? -widget.buttonHigh / 4
                          : 0,
                      // top: 0,
                      duration: const Duration(milliseconds: 100),
                      child: AnimatedContainer(
                        duration: widget.duration,
                        width: state.index == widget.index ? 40 : 50,
                        height:
                        state.index == widget.index ? 40 : widget.buttonHigh/2,
                        decoration: BoxDecoration(
                            boxShadow: state.index == widget.index
                                ? [
                              BoxShadow(
                                color: ColorManager.black.withOpacity(0.4),
                                blurRadius: 4,
                                spreadRadius: 0.2,
                                offset: const Offset(0, 2),
                              )
                            ]
                                : null,
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(
                                state.index == widget.index ? 50 : 0)),
                        child: Icon(
                          widget.child,
                          size: widget.iconSize,
                          color: state.index == widget.index
                              ? widget.iconActiveColor
                              : widget.iconDisabledColor??ColorManager.darkGrey,
                        ),
                      ),
                    )
                  ],
                ),
            );
          } else {
            return Listener(
              onPointerUp: (_) {
                widget.onTap?.call(widget.index);
                BlocProvider.of<NavigationBarBloc>(context)
                    .add(Animate(widget.index));
              },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  fit: StackFit.loose,
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: ClipPath(
                        clipper: _ButtonClipper(
                            halfContainerWidth: 25, animate: false,widgetHeight: widget.buttonHigh),
                        child: Container(
                          decoration:  BoxDecoration(
                            color: ColorManager.white,
                            // color: Colors.transparent
                          ),
                          width: widget.buttonWidth,
                          height: widget.buttonHigh/2,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      top: widget.buttonHigh/2,
                      duration: const Duration(milliseconds: 100),
                      child: AnimatedContainer(
                        duration: widget.duration,
                        width: 50,
                        height: widget.buttonHigh/2,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(0)),
                        child: Icon(
                          widget.child,
                          size: widget.iconSize,
                          color: widget.iconDisabledColor,
                        ),
                      ),
                    )
                  ],
                ),
            );
          }
        },
      ),
    );
  }
}






class _ButtonClipper extends CustomClipper<Path> {
  final double halfContainerWidth;
  final bool animate;
  final double widgetHeight;

  _ButtonClipper( {
    required this.halfContainerWidth,
    required this.animate,
    required this.widgetHeight,
  });

  @override
  Path getClip(Size size) {

    Path path = Path();
    path.moveTo(0, 0);
    if (animate) {
      path.quadraticBezierTo(size.width / 2 - halfContainerWidth - 2, -5,
          size.width / 2 - halfContainerWidth + 4, 8);
      //to find the correct relative
      double r = (-4/21*size.height+17)/10;
      //
      path.quadraticBezierTo(size.width / 2,size.height *r,
          size.width / 2 + halfContainerWidth - 4, 8);

      path.quadraticBezierTo(
          size.width / 2 + halfContainerWidth +4, -5, size.width, 0);
    } else {
      path.lineTo(size.width, 0);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
