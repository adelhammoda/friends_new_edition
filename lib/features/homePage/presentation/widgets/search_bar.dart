import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_widget/input_field.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/homePage/presentation/manager/homepage_offer_bloc.dart';
import 'package:responsive_s/responsive_s.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;


  const SearchBar(
      {Key? key,
      required this.controller,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: responsive.responsiveHeight(forUnInitialDevices: 8),
          horizontal: responsive.responsiveWidth(forUnInitialDevices: 6)),
      child: FriendInputField(
        onChanges: (val) {
          if (val != null) {
            BlocProvider.of<HomepageBloc>(context)
                .add(HomepageSearchEvent(val));
          }
        },
        icon: const Icon(Icons.search),
        hint: StringManager.search,
        controller: controller,
      ),
    );
  }
}
