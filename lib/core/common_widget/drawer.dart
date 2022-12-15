import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/log/log.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/icon_manager.dart';
import 'package:friends/core/manager/size_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/core/manager/theme_manager.dart';
import 'package:responsive_s/responsive_s.dart';

class FriendsDrawer extends StatefulWidget {
  final UserEntity? user;

  const FriendsDrawer({Key? key, required this.user}) : super(key: key);

  @override
  State<FriendsDrawer> createState() => _FriendsDrawerState();
}

class _FriendsDrawerState extends State<FriendsDrawer> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(
      context,
      removePadding: false,
    );
    return Drawer(
      child: SizedBox(
        height: responsive.responsiveHeight(forUnInitialDevices: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            buildUserProfileImage(responsive),
            buildUserName(responsive, context),
            buildUserEmail(responsive, context),
            DayNightSwitcher(
              isDarkModeEnabled: ThemeManager.themeMode==ThemeMode.dark,
              onStateChanged: (isDarkModeEnabled) {
                PrintLog.call(
                    tag: "Switch theme",
                    message:
                        'the current value of dark is $isDarkModeEnabled \n theme manager value is ${ThemeManager.themeMode} ');
                  ThemeManager.themeMode =
                      isDarkModeEnabled ? ThemeMode.light : ThemeMode.dark;
              },
            ),
            const Divider(
              color: ColorManager.white,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 13,
              ),
              child: buildNavigationTiles(
                  MyFlutterApp.setting, StringManager.setting, context),
            ),
            const Divider(
              color: ColorManager.white,
              thickness: 1,
            ),
            widget.user != null
                ? Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(
                            right: 25, left: 15, top: 20, bottom: 20),
                        child: Icon(
                          MyFlutterApp.delete,
                          color: ColorManager.white,
                        ),
                      ),
                      Text(
                        StringManager.deleteAccount,
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  fontSize: SizeManager.listTileTitle,
                                  color: ColorManager.white,
                                ),
                      )
                    ],
                  )
                : const SizedBox(),
            widget.user != null
                ? const Divider(
                    color: ColorManager.white,
                    thickness: 1,
                  )
                : const SizedBox(),
            const Spacer(),
            widget.user != null
                ? TextButton(
                    onPressed: () {
                      // BlocProvider.of<UserDetailsBloc>(context).logout();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.logout,
                            color: ColorManager.white,
                          ),
                        ),
                        Text(
                          StringManager.logout,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: SizeManager.listTileTitle),
                        )
                      ],
                    ))
                : const SizedBox(),
          ],
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
            image: NetworkImage(widget.user?.imageUrl ?? ""),
            placeholder: const AssetImage(AssetsManager.userImagePlaceHolder),
            imageErrorBuilder: (c, _, __) => Image.asset(
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
        widget.user?.name ?? ConstantManager.stackHolderName,
        style: Theme.of(context)
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
        widget.user?.email ?? ConstantManager.stackHolderEmail,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: SizeManager.titleMedium,
              color: ColorManager.white,
            ),
      ),
    );
  }

  Widget buildNavigationTiles(
      IconData iconData, String text, BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Icon(
        iconData,
        color: ColorManager.white,
      ),
      title: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(fontSize: SizeManager.listTileTitle),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_sharp,
        color: ColorManager.white,
      ),
    );
  }
}
