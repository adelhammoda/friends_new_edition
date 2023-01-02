import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_bloc/setting_bloc/setting_bloc.dart';
import 'package:friends/core/common_widget/friends_button.dart';
import 'package:friends/core/common_widget/snackbar_widget.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/log/log.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/icon_manager.dart';
import 'package:friends/core/manager/size_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/core/manager/theme_manager.dart';
import 'package:friends/core/navigation/navigator.dart';
import 'package:responsive_s/responsive_s.dart';

class FriendsDrawer extends StatelessWidget {
  final UserEntity? user;

  const FriendsDrawer({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(
      context,
      removePadding: false,
    );
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is ErrorState) {
          Go.back(context, null);
          bool warning = state.failureType == FailureType.error;
          ScaffoldMessenger.of(context).showSnackBar(MessageSnackBar(
            context,
            responsive: responsive,
            errorMessage: state.failure,
            textHeaderColor:
            warning ? ColorManager.bellColor : ColorManager.error,
            animationString: warning
                ? AssetsManager.bellAnimation
                : AssetsManager.wrongAnimation,
            borderColor: warning ? ColorManager.bellColor : ColorManager.error,
            textHeader: warning ? StringManager.warning(context) : StringManager
                .error(context),
          ));
        } else if (state is SuccessState) {
          Go.back(context, null);
          ScaffoldMessenger.of(context).showSnackBar(MessageSnackBar(
            context,
            responsive: responsive,
            errorMessage: state.message,
            animationString: AssetsManager.successAnimation,
            textHeader: StringManager.success(context),
            borderColor: ColorManager.lightGreen,
            textHeaderColor: ColorManager.lightGreen,
          ));
        }
      },
      child: Drawer(
        child: SizedBox(
          height: responsive.responsiveHeight(forUnInitialDevices: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              buildUserProfileImage(responsive),
              user?.name == null ? Container() : buildUserName(
                  responsive, context),
              user?.email == null ? Container() : buildUserEmail(
                  responsive, context),
              DayNightSwitcher(
                isDarkModeEnabled: ThemeManager.themeMode == ThemeMode.dark,
                onStateChanged: (isDarkModeEnabled) {
                  final isDark = ThemeManager.themeMode == ThemeMode.dark;
                  ThemeManager.themeMode =
                  isDark ? ThemeMode.light : ThemeMode.dark;
                  PrintLog.call(
                      tag: "Switch theme",
                      message:
                      'the current value of dark is $isDarkModeEnabled \n theme manager value is ${ThemeManager
                          .themeMode} ');
                  isDarkModeEnabled
                      ? ColorManager.switchToDark()
                      : ColorManager.switchToLight();

                  BlocProvider.of<SettingBloc>(context).add(RebuildTheAppEvent(
                      event: "Switch the theme to $isDarkModeEnabled",
                      local: Localizations.localeOf(context),
                      isDark: isDark));
                },
              ),
              Divider(
                color: ColorManager.white,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 13,
                ),
                child: buildNavigationTiles(
                    MyFlutterApp.setting, StringManager.languages(context),
                    context,
                    onTap: () {
                      showGeneralDialog(
                        barrierDismissible: true,
                        barrierLabel: '',
                        transitionDuration: const Duration(
                            milliseconds: 200),

                        context: context,
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return ScaleTransition(
                            scale: animation,
                            child:Dialog(
                              elevation: 0,
                              insetPadding:  EdgeInsets.all(responsive.responsiveWidth(forUnInitialDevices: 30)),
                              backgroundColor: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FriendsButton(
                                        child: Text(
                                          StringManager.arabic(context),
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                              fontSize: SizeManager.listTileTitle,
                                              color: ColorManager.white),
                                        ),
                                        onPressed: () {
                                          BlocProvider.of<SettingBloc>(context)
                                              .add(
                                              const RebuildTheAppEvent(
                                                  local: Locale('ar')));
                                          Go.back(context, key);
                                        }, width: 30,
                                    height: 5,),
                                    const SizedBox(height: 5,),
                                    FriendsButton(
                                        width:30,
                                        height: 5,
                                        child: Text(
                                          StringManager.english(context),
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                              fontSize: SizeManager.listTileTitle,
                                              color: ColorManager.white),
                                        ),
                                        onPressed: () {
                                          BlocProvider.of<SettingBloc>(context)
                                              .add(
                                              const RebuildTheAppEvent(
                                                  local: Locale('en')));
                                          Go.back(context, key);
                                        }),
                                  ],
                                ),
                              ),
                            ) ,
                          );
                        },);
                    }),
              ),
              Divider(
                color: ColorManager.white,
                thickness: 1,
              ),
              user != null
                  ? InkWell(
                onTap: () async {
                  String? userEmail = (user?.email ?? "") ==
                      ConstantManager.stackHolderEmail
                      ? null
                      : user?.email;
                  BlocProvider.of<SettingBloc>(context).add(
                      DeleteAccountEvent(
                          context: context, userEmail: userEmail));
                },
                child: BlocBuilder<SettingBloc, SettingState>(
                  builder: (context, state) {
                    return AbsorbPointer(
                      absorbing: state is LoadingState,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 25, left: 15, top: 20, bottom: 20),
                            child: Icon(
                              MyFlutterApp.delete,
                              color: ColorManager.white,
                            ),
                          ),
                          Text(
                            StringManager.deleteAccount(context),
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                              fontSize: SizeManager.listTileTitle,
                              color: ColorManager.white,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
                  : const SizedBox(),
              user != null
                  ? Divider(
                color: ColorManager.white,
                thickness: 1,
              )
                  : const SizedBox(),
              const Spacer(),
              user != null
                  ? BlocBuilder<SettingBloc, SettingState>(
                builder: (context, state) {
                  return AbsorbPointer(
                    absorbing: state is LoadingState,
                    child: TextButton(
                        onPressed: () {
                          String? userEmail =
                          (user?.email ?? "") ==
                              ConstantManager.stackHolderEmail
                              ? null
                              : user?.email;
                          BlocProvider.of<SettingBloc>(context).add(
                              LogoutEvent(
                                  userEmail: userEmail,
                                  context: context));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.logout,
                                color: ColorManager.white,
                              ),
                            ),
                            Text(
                              StringManager.logout(context),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                  fontSize:
                                  SizeManager.listTileTitle),
                            )
                          ],
                        )),
                  );
                },
              )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserProfileImage(Responsive responsive) {
    return SizedBox(
      height: responsive.responsiveHeight(forUnInitialDevices: 30),
      child: Padding(
        padding: EdgeInsets.only(
            top: responsive.responsiveHeight(forUnInitialDevices: 6)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: FadeInImage(
            image: NetworkImage(user?.imageUrl ?? ""),
            placeholder: const AssetImage(AssetsManager.userImagePlaceHolder),
            imageErrorBuilder: (c, _, __) =>
                Image.asset(
                  AssetsManager.userImagePlaceHolder,
                  fit: BoxFit.fill,
                ),
            placeholderFit: BoxFit.fill,
            fit: BoxFit.fill,
            width: responsive.responsiveWidth(forUnInitialDevices: 35),
            height: responsive.responsiveWidth(forUnInitialDevices: 35),
          ),
        ),
      ),
    );
  }

  Widget buildUserName(Responsive responsive, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        user?.name ?? ConstantManager.stackHolderName,
        style: Theme
            .of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: ColorManager.white),
      ),
    );
  }

  Widget buildUserEmail(Responsive responsive, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 25),
      child: Text(
        user?.email ?? ConstantManager.stackHolderEmail,
        style: Theme
            .of(context)
            .textTheme
            .labelMedium!
            .copyWith(
          fontSize: SizeManager.titleMedium,
          color: ColorManager.white,
        ),
      ),
    );
  }

  Widget buildNavigationTiles(IconData iconData, String text,
      BuildContext context,
      {void Function()? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        iconData,
        color: ColorManager.white,
      ),
      title: Text(
        text,
        style: Theme
            .of(context)
            .textTheme
            .displayMedium!
            .copyWith(fontSize: SizeManager.listTileTitle),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        color: ColorManager.white,
      ),
    );
  }
}
