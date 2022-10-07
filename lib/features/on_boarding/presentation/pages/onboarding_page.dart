import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_widget/friends_button.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/on_boarding/presentation/manager/on_boarding_bloc.dart';
import 'package:friends/features/on_boarding/presentation/widgets/line.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:friends/injection_container.dart' as di;


class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _alignmentAnimation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    _alignmentAnimation = Tween(begin: 20.0,end: 0.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    final topPosition = responsive.responsiveHeight(forUnInitialDevices: _alignmentAnimation.value);
    final topPadding = responsive.responsiveHeight(forUnInitialDevices: 20);
    return BlocProvider<OnBoardingBloc>(
        create: (s) => di.sl(),
        child: BlocBuilder<OnBoardingBloc, OnBoardingState>(
          builder: (context, state) {
            if (state is OnBoardingInitial) {
              BlocProvider.of<OnBoardingBloc>(context)
                  .add(OnBoardingAutoLoginEvent());
            } else if (state is OnBoardingError) {
                debugPrint(state.failure.message);
                _controller.forward();
            }
            return Scaffold(
              body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          AssetsManager.onBoardingBackground,
                        ),
                        fit: BoxFit.fill)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: AnimatedBuilder(
                    builder: (context, widget) => Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top:topPadding),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 700),
                            opacity: _opacityAnimation.value,
                              child: widget!),
                        ),
                        Positioned(
                          top: topPosition,
                            child: Padding(
                          padding: EdgeInsets.only(
                              top: responsive.responsiveHeight(
                                  forUnInitialDevices: 15),
                              bottom: responsive.responsiveHeight(
                                  forUnInitialDevices: 7)),
                          child: SizedBox(
                              width: responsive.responsiveWidth(
                                  forUnInitialDevices: 80),
                              // height: responsive.responsiveWidth(forUnInitialDevices: 40),
                              child: Image.asset(
                                AssetsManager.mediumLogo,
                                fit: BoxFit.fill,
                              )),
                        ))
                      ],
                    ),
                    animation: _controller,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FriendsButton(
                            onPressed: () {
                              BlocProvider.of<OnBoardingBloc>(context)
                                  .add(OnBoardingNavigateToLogin(context));
                            },
                            width: 80,
                            height: 10,
                            child: Text(
                              StringManager.login,
                              style: Theme.of(context).textTheme.displayMedium,
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Line(),
                              Text(
                                StringManager.or,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 20),
                              ),
                              const Line()
                            ],
                          ),
                        ),
                        FriendsButton(
                            onPressed: () {
                              BlocProvider.of<OnBoardingBloc>(context)
                                  .add(OnBoardingNavigateToRegister(context));
                            },
                            width: 80,
                            height: 10,
                            child: Text(
                              StringManager.createAccount,
                              style: Theme.of(context).textTheme.displayMedium,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
