import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_widget/another_login_option.dart';
import 'package:friends/core/common_widget/app_bar.dart';
import 'package:friends/core/common_widget/background_widget.dart';
import 'package:friends/core/common_widget/friends_button.dart';
import 'package:friends/core/common_widget/input_field.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/login/presentation/manager/login_bloc.dart';
import 'package:responsive_s/responsive_s.dart';


import '../../../../core/common_widget/footer.dart';
import '../../../../core/common_widget/loader.dart';
import '../../../../injection_container.dart' as di;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //editors
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //for animation
  late Responsive _responsive;

  late double? height = _responsive.responsiveHeight(forUnInitialDevices: 15);

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    _responsive = Responsive(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (c)=>di.sl<LoginBloc>(),child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: FriendsAppbar(),
      bottomNavigationBar: const Footer(
        ///example of url that worked natively "mailto:adel@gmail.com"
        emailUrlNatively: 'emailNativelyUrl',

        ///example of url that worked natively 'fb://profile/100004920094579'
        facebookUrlNatively: 'facebookNativelyUrl',

        ///example of url that worked natively 'instagram://user?username=aadel_hammoda'
        instagramUrlNatively: "instagramNativelyUrl",

        ///example of url that work in web-view mood "https://www.gmail.com"
        emailUrl: "emailUrl",

        ///example of url that work in web-view mood 'https://www.facebook.com/aadel.hammoda'
        facebookUrl: "facebookUrl",

        ///example of url that work in web-view mood 'https://www.instagram.com/moaazallaham/'
        instagramUrl: "instagramUrl",
      ),
      body: FriendsBackgroundWidget(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Text(
                    StringManager.login,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      switch(state.runtimeType){
                        case LoginInitial:case LoadedState:
                        return AnotherLoginOption(
                          onTap: () {
                            BlocProvider.of<LoginBloc>(context).add(LoginWithGoogleEvent());
                          },
                          image: AssetsManager.googleLogo,
                          content: StringManager.loginWithGoogle,
                        );
                        case LoadingState:
                          {
                            print(state.props);
                            if((state as LoadingState).loadingIn==ConstantManager.loadingStatusForLoginWithGoogle){
                            return const Loader();
                          }else{
                            return AnotherLoginOption(
                              onTap: () {
                                //TODO:add login with google option;
                              },
                              image: AssetsManager.googleLogo,
                              content: StringManager.loginWithGoogle,
                            );
                          }

                          }
                        default:
                          return AnotherLoginOption(
                            onTap: () {
                              //TODO:add login with google option;
                            },
                            image: AssetsManager.googleLogo,
                            content: StringManager.loginWithGoogle,
                          );
                      }

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: AnotherLoginOption(
                    onTap: () {
                      //TODO:add login with facebook option;
                    },
                    image: AssetsManager.facebookLogo,
                    content: StringManager.loginWithFacebook,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: AnotherLoginOption(
                    onTap: () {
                      //TODO:add login with apple option;
                    },
                    image: AssetsManager.appleLogo,
                    content: StringManager.loginWithApple,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: height,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        //this physics have some denied user from scrolling in the page.
                        // physics:  height == _responsive.responsiveHeight(forUnInitialDevices: 15)?const NeverScrollableScrollPhysics():const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0, top: 5),
                              child: AnotherLoginOption(
                                onTap: () {
                                  setState(() {
                                    height = height ==
                                        _responsive.responsiveHeight(
                                            forUnInitialDevices: 15)
                                        ? _responsive.responsiveHeight(
                                        forUnInitialDevices: 40)
                                        : _responsive.responsiveHeight(
                                        forUnInitialDevices: 15);
                                  });
                                },
                                image: AssetsManager.emailLogo,
                                content: StringManager.loginWithEmail,
                              ),
                            ),
                            FriendInputField(
                                hint: StringManager.emailHint,
                                icon: const Icon(Icons.person),
                                controller: emailController),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: FriendInputField(
                                  hint: StringManager.passwordHint,
                                  icon: const Icon(Icons.lock),
                                  controller: passwordController),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    //TODO:create account
                                  },
                                  child: Text(
                                    StringManager.createAccount,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    //TODO:forget password
                                  },
                                  child: Text(
                                    StringManager.forgetPassword,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: FriendsButton(
                      onPressed: () {
                        //TODO:login on pressed.
                      },
                      child: Text(StringManager.login,
                          style: Theme.of(context).textTheme.displayMedium)),
                ),
              ],
            ),
          )),
    ),);
  }
}
