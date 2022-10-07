import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_widget/another_login_option.dart';
import 'package:friends/core/common_widget/app_bar.dart';
import 'package:friends/core/common_widget/background_widget.dart';
import 'package:friends/core/common_widget/footer.dart';
import 'package:friends/core/common_widget/friends_button.dart';
import 'package:friends/core/common_widget/input_field.dart';
import 'package:friends/core/common_widget/loader.dart';
import 'package:friends/core/common_widget/snackbar_widget.dart';
import 'package:friends/core/manager/icon_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/navigation/navigator.dart';
import 'package:friends/core/routes/routes.dart';
import 'package:friends/core/validator/validator.dart';
import 'package:friends/features/login/presentation/widgets/build_options_buttons.dart';
import 'package:friends/features/register/data/models/user_model.dart';
import 'package:friends/features/register/presentation/manager/register_bloc.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:friends/injection_container.dart' as di;

class RegisterPage extends StatelessWidget {
  ///controllers
  final PageController _controller = PageController(
    initialPage: 0,
  );

  //controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _validate = GlobalKey();

  //focus node
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return BlocProvider<RegisterBloc>(
      create: (context) => di.sl(),
      lazy: true,
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
          leftPadding: 0,
          rightPadding: 0,
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
                        event: SignupWithGoogle(context),
                        image: AssetsManager.googleLogo,
                        content: StringManager.signupWithGoogle,
                        loadingStatus: ConstantManager
                            .loadingStatusForAuthenticationWithGoogle),
                    buildAuthOptionButton<RegisterBloc, RegisterState,
                            RegisterEvent>(
                        responsive: responsive,
                        event: SignupWithApple(context),
                        image: AssetsManager.appleLogo,
                        content: StringManager.signupWithApple,
                        loadingStatus: ConstantManager
                            .loadingStatusForAuthenticationWithApple),
                    buildAuthOptionButton<RegisterBloc, RegisterState,
                            RegisterEvent>(
                        responsive: responsive,
                        event: SignupWithFacebook(context),
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
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          },
                          image: AssetsManager.emailLogo,
                          content: StringManager.signupWithEmail),
                    ),
                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: responsive.responsiveWidth(
                                  forUnInitialDevices: 10)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                                onPressed: () {
                                  BlocProvider.of<RegisterBloc>(context).add(
                                      AlreadyHaveAccountNavigator(context));
                                },
                                child: Text(
                                  StringManager.alreadyHaveAccount,
                                  style: Theme.of(context).textTheme.bodySmall,
                                )),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  key: _validate,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: FriendInputField(
                              textInputType: TextInputType.name,
                              focusNode: _nameFocusNode,
                              onFieldSubmitted: (_) {
                                _passwordFocusNode.requestFocus();
                                return null;
                              },
                              validator: Validator.emptyField,
                              hint: StringManager.userName,
                              icon: const Icon(MyFlutterApp.user),
                              controller: _nameController),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: FriendInputField(
                              hideText: true,
                              onFieldSubmitted: (_) {
                                _confirmPasswordFocusNode.requestFocus();
                                return null;
                              },
                              textInputType: TextInputType.text,
                              focusNode: _passwordFocusNode,
                              validator: Validator.passwordValidator,
                              hint: StringManager.passwordHint,
                              icon: const Padding(
                                padding: EdgeInsets.all(14),
                                child: Icon(MyFlutterApp.open_lock),
                              ),
                              controller: _passwordController),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: FriendInputField(
                              hideText: true,
                              onFieldSubmitted: (_) {
                                _emailFocusNode.requestFocus();
                                return null;
                              },
                              focusNode: _confirmPasswordFocusNode,
                              validator: (val) => Validator.confirmPassword(
                                  val, _passwordController.text),
                              hint: StringManager.confirmPassword,
                              icon: const Padding(
                                padding: EdgeInsets.all(14),
                                child: Icon(MyFlutterApp.lock),
                              ),
                              controller: _confirmPasswordController),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: FriendInputField(
                              onFieldSubmitted: (_) {
                                _phoneNumberFocusNode.requestFocus();
                                return null;
                              },
                              focusNode: _emailFocusNode,
                              validator: Validator.emailValidation,
                              hint: StringManager.emailHint,
                              textInputType: TextInputType.emailAddress,
                              icon: const Padding(
                                padding: EdgeInsets.all(14),
                                child: Icon(Icons.email),
                              ),
                              controller: _emailController),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: FriendInputField(
                              textInputAction: TextInputAction.done,
                              focusNode: _phoneNumberFocusNode,
                              validator: Validator.containNumber,
                              onFieldSubmitted: (_) {
                                _phoneNumberFocusNode.unfocus();
                                return null;
                              },
                              textInputType: TextInputType.phone,
                              suffixText: StringManager.optional,
                              prefixText: ConstantManager.syrianNumber,
                              hint: StringManager.phoneNumber,
                              icon: const Padding(
                                padding: EdgeInsets.all(14),
                                child: Icon(Icons.phone),
                              ),
                              controller: _phoneNumberController),
                        ),
                        BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (context, state) {
                            Widget button = FriendsButton(
                              height: 13,
                              width: 70,
                              child: Text(
                                StringManager.create,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (_validate.currentState?.validate() ??
                                    false) {
                                  UserModel user = UserModel(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      user: ConstantManager.studentType,
                                      imageUrl: null,
                                      subscribeId: null,
                                      address: null);
                                  BlocProvider.of<RegisterBloc>(context).add(
                                      SignupWithEmailAndPassword(user,
                                          _passwordController.text, context));
                                }
                              },
                            );
                            if (state is LoadingState) {
                              return const Loader();
                            } else if (state is RegisterInitial) {
                              return button;
                            } else if (state is LoadedState) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                Go.to(context, Routes.homePage);
                              });
                              return button;
                            } else if (state is ErrorState) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    MessageSnackBar(context,
                                        responsive: responsive,
                                        success: false,
                                        errorMessage: state.failure.message));
                              });
                              return button;
                            } else {
                              return button;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
