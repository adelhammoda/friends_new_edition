import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_bloc/user_details_manager/user_details_bloc.dart';
import 'package:friends/core/common_widget/snackbar_widget.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/size_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/QRScanner/presentation/widgets/animated_loading_circle.dart';
import 'package:responsive_s/responsive_s.dart';
import 'package:friends/core/extension/string_extension.dart';

class UserSection extends StatelessWidget {
  const UserSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return BlocConsumer<UserDetailsBloc, UserDetailsState>(
      listener: (context, state) {
        if (state is ErrorUserDetailsState) {
          ScaffoldMessenger.of(context).showSnackBar(MessageSnackBar(context,
              responsive: responsive, errorMessage: state.failure.message));
        }
      },
      builder: (context, state) {
        if (state is LoadedUserDetailsState) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: responsive.responsiveHeight(forUnInitialDevices: 5)),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorManager.black.withOpacity(0.4),
                          width: 1.2),
                      shape: BoxShape.circle),
                  child: state.userEntity.imageUrl.isNullOrEmpty()
                      ? CircleAvatar(
                          backgroundImage: const AssetImage(
                              AssetsManager.userPlaceHolderIcon),
                          backgroundColor: ColorManager.darkGreen,
                          radius: responsive.responsiveValue(
                              forUnInitialDevices: 33),
                        )
                      : CircleAvatar(
                          backgroundImage:
                              NetworkImage(state.userEntity.imageUrl!),
                          backgroundColor: ColorManager.darkGreen,
                          radius: responsive.responsiveValue(
                              forUnInitialDevices: 33),
                        ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: responsive.responsiveHeight(forUnInitialDevices: 5),
                      left:
                          responsive.responsiveWidth(forUnInitialDevices: 15)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      state.userEntity.name,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ColorManager.black,
                          fontFamily: AssetsManager.roboto,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(
                    top: responsive.responsiveHeight(forUnInitialDevices: 0.7),
                    left: responsive.responsiveWidth(forUnInitialDevices: 15)),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      state.userEntity.email,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: SizeManager.listTileTitle),
                    )),
              ),
            ],
          );
        } else if (state is LoadingUserDetailsState) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: responsive.responsiveHeight(forUnInitialDevices: 5)),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorManager.black.withOpacity(0.4),
                          width: 1.2),
                      shape: BoxShape.circle),
                  child: AnimatedLoadingCircle(
                    radius: responsive.responsiveValue(forUnInitialDevices: 66),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: responsive.responsiveHeight(forUnInitialDevices: 5),
                      left:
                          responsive.responsiveWidth(forUnInitialDevices: 15)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: List.generate(
                          4,
                          (index) => const Padding(
                                padding: EdgeInsets.only(
                                  left: 2,
                                ),
                                child: AnimatedLoadingCircle(
                                  radius: 10,
                                ),
                              )),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(
                    top: responsive.responsiveHeight(forUnInitialDevices: 0.7),
                    left: responsive.responsiveWidth(forUnInitialDevices: 15)),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: List.generate(
                          8,
                          (index) => const Padding(
                                padding: EdgeInsets.only(
                                  left: 2,
                                ),
                                child: AnimatedLoadingCircle(
                                  radius: 10,
                                ),
                              )),
                    )),
              ),
            ],
          );
        } else {
          return SizedBox(
            height: responsive.responsiveHeight(forUnInitialDevices: 50),
            child: Center(
              child: Text(
                StringManager.userNotFoundErrorMessage,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }
      },
    );
  }
}
