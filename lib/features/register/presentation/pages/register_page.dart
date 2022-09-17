import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_widget/another_login_option.dart';
import 'package:friends/core/common_widget/app_bar.dart';
import 'package:friends/core/common_widget/background_widget.dart';
import 'package:friends/core/common_widget/friends_button.dart';
import 'package:friends/core/common_widget/input_field.dart';
import 'package:friends/core/manager/icon_manager.dart';
import 'package:friends/features/register/presentation/manager/register_bloc.dart';
import 'package:responsive_s/responsive_s.dart';

import '../../../../core/common_widget/footer.dart';
import '../../../../core/manager/string_manager.dart';
import '../../../login/presentation/widgets/build_options_buttons.dart';
import '../../../../injection_container.dart' as di;

class RegisterPage extends StatelessWidget {
  ///controllers
  final PageController _controller = PageController(
    initialPage: 0,
  );
  final TextEditingController _nameController = TextEditingController();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return BlocProvider<RegisterBloc>(
      create: (context) => di.sl(),
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
        body: FriendsBackgroundWidget(
          child: PageView(
            controller: _controller,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Text(
                        StringManager.register,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    buildAuthOptionButton<RegisterBloc, RegisterState,
                            RegisterEvent>(
                        responsive: responsive,
                        event: const SignupWithGoogle(),
                        image: AssetsManager.googleLogo,
                        content: StringManager.signupWithGoogle,
                        loadingStatus: ConstantManager
                            .loadingStatusForAuthenticationWithGoogle),
                    buildAuthOptionButton<RegisterBloc, RegisterState,
                            RegisterEvent>(
                        responsive: responsive,
                        event: const SignupWithApple(),
                        image: AssetsManager.appleLogo,
                        content: StringManager.signupWithApple,
                        loadingStatus: ConstantManager
                            .loadingStatusForAuthenticationWithApple),
                    buildAuthOptionButton<RegisterBloc, RegisterState,
                            RegisterEvent>(
                        responsive: responsive,
                        event: const SignupWithFacebook(),
                        image: AssetsManager.facebookLogo,
                        content: StringManager.signupWithFacebook,
                        loadingStatus: ConstantManager
                            .loadingStatusForAuthenticationWithFacebook),
                    const Divider(
                      indent: 20,
                      endIndent: 20,
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: AnotherLoginOption(
                          onTap: () {
                            _controller.nextPage(
                                duration:
                                    const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          },
                          image: AssetsManager.emailLogo,
                          content: StringManager.signupWithEmail),
                    ),
                      const SizedBox(height: 40,)
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: FriendInputField(
                          hint: StringManager.userName,
                          icon: const Icon(MyFlutterApp.user),
                          controller: _nameController),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: FriendInputField(
                          hint: StringManager.passwordHint,
                          icon:const Padding(
                            padding:  EdgeInsets.all(14),
                            child: Icon(MyFlutterApp.open_lock),
                          ),
                          controller: _nameController),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: FriendInputField(
                          hint: StringManager.confirmPassword,
                          icon:const Padding(
                            padding:  EdgeInsets.all(14),
                            child: Icon(MyFlutterApp.lock),
                          ),
                          controller: _nameController),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: FriendInputField(
                          hint: StringManager.emailHint,
                          icon:const Padding(
                            padding:  EdgeInsets.all(14),
                            child: Icon(Icons.email),
                          ),
                          controller: _nameController),
                    ),
                    FriendsButton(
                      child: Text(
                        StringManager.create,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 40,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
