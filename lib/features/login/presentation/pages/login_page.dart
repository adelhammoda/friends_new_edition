import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_widget/another_login_option.dart';
import 'package:friends/core/common_widget/app_bar.dart';
import 'package:friends/core/common_widget/background_widget.dart';
import 'package:friends/core/common_widget/friends_button.dart';
import 'package:friends/core/common_widget/input_field.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/login/presentation/manager/login_bloc.dart';
import 'package:friends/features/login/presentation/widgets/build_options_buttons.dart';
import 'package:responsive_s/responsive_s.dart';

import '../../../../core/common_widget/footer.dart';
import '../../../../core/common_widget/loader.dart';
import '../../../../core/common_widget/snackbar_widget.dart';
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
  final ScrollController scrollController = ScrollController();
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
    return BlocProvider(
      create: (c) => di.sl<LoginBloc>(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
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
        body: SingleChildScrollView(
          child: FriendsBackgroundWidget(
              child: SingleChildScrollView(
                primary: true,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Text(
                    StringManager.login,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                buildAuthOptionButton<LoginBloc,LoginState,LoginEvent>(
                    responsive: _responsive,
                    event: LoginWithGoogleEvent(),
                    image: AssetsManager.googleLogo,
                    content: StringManager.loginWithGoogle,
                    loadingStatus:
                        ConstantManager.loadingStatusForAuthenticationWithGoogle),
                buildAuthOptionButton<LoginBloc,LoginState,LoginEvent>(
                    event: LoginWithFacebookEvent(),
                    responsive: _responsive,
                    image: AssetsManager.facebookLogo,
                    content: StringManager.loginWithFacebook,
                    loadingStatus:
                        ConstantManager.loadingStatusForAuthenticationWithFacebook),
                buildAuthOptionButton<LoginBloc,LoginState,LoginEvent>(
                    event: LoginWithAppleEvent(),
                    responsive: _responsive,
                    image: AssetsManager.appleLogo,
                    content: StringManager.loginWithApple,
                    loadingStatus:
                        ConstantManager.loadingStatusForAuthenticationWithApple),
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
                              padding:
                                  const EdgeInsets.only(bottom: 15.0, top: 5),
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
                                    BlocProvider.of<LoginBloc>(context)
                                        .add(CreateAccountNavigatorEvent(
                                      context: context,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ));
                                  },
                                  child: Text(
                                    StringManager.createAccount,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    BlocProvider.of<LoginBloc>(context).add(
                                        ForgetPasswordNavigatorEvent(context));
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
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if(state is ErrorState){
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                              MessageSnackBar(context,
                                responsive: _responsive,errorMessage: state.failure.message,success: false,));
                        });
                      }
                        final loginOption = FriendsButton(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginWithEmailAndPasswordEvent(
                                      emailController.text,
                                      passwordController.text));
                            },
                            child: Text(StringManager.login,
                                style: Theme.of(context).textTheme.displayMedium));
                      switch(state.runtimeType){
                        case LoadingState:
                          {
                            if((state as LoadingState).loadingIn==ConstantManager.loadingStatusForAuth){
                              return const Loader();
                            }else{
                              return loginOption;
                            }
                          }
                        case ErrorState:
                          {
                            return loginOption;
                          }
                        case LoadedState:{
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                                MessageSnackBar(context,
                                  responsive: _responsive,errorMessage: ConstantManager.success,success: true,));
                          });
                          return loginOption;
                        }
                        case LoginInitial:default:
                        return loginOption;
                      }

                    },
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}



