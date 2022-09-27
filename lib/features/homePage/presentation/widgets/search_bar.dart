import 'package:flutter/material.dart';
import 'package:friends/core/common_widget/input_field.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:responsive_s/responsive_s.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  const SearchBar({Key? key,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return   Padding(
      padding: EdgeInsets.symmetric(
          vertical: responsive.responsiveHeight(forUnInitialDevices: 8),
          horizontal: responsive.responsiveWidth(forUnInitialDevices: 6)
      ),
      child:FriendInputField(
        icon: const Icon(Icons.search),
        hint: StringManager.search,
        controller: controller,
      ) ,
    );
  }
}
