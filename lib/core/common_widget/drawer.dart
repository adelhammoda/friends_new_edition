import 'package:flutter/material.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/icon_manager.dart';
import 'package:friends/core/manager/size_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/login/domain/entities/user_entity.dart';
import 'package:responsive_s/responsive_s.dart';

class FriendsDrawer extends StatelessWidget {
  final UserEntity user;

  const FriendsDrawer({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context,
        removePadding: false,);
    return Drawer(
      child: SingleChildScrollView(
        child: SizedBox(
          height: responsive.responsiveHeight(forUnInitialDevices: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              buildUserProfileImage(responsive),
              buildUserName(responsive, context),
              buildUserEmail(responsive, context),
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
              buildNavigationTiles(
                  MyFlutterApp.smileEmoji, StringManager.mode, context),
              const Divider(
                color: ColorManager.white,
                thickness: 1,
              ),
              Row(
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
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: SizeManager.listTileTitle,
                          color: ColorManager.white,
                        ),
                  )
                ],
              ),
              const Divider(
                color: ColorManager.white,
                thickness: 1,
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {},
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
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserProfileImage(Responsive responsive) {
    return Padding(
      padding: EdgeInsets.only(
          top: responsive.responsiveHeight(forUnInitialDevices: 6)),
      child: CircleAvatar(
        backgroundColor: ColorManager.white,
        radius: 80,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: FadeInImage(
            image: NetworkImage(user.imageUrl ?? ""),
            placeholder: const AssetImage(AssetsManager.userImagePlaceHolder),
            imageErrorBuilder: (c, _, __) => Image.asset(
              AssetsManager.userImagePlaceHolder,
              fit: BoxFit.fill,
            ),
            placeholderFit: BoxFit.fill,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget buildUserName(Responsive responsive, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        user.name,
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
        user.email,
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
