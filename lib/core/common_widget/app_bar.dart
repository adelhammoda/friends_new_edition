import 'package:flutter/material.dart';
import 'package:friends/core/common_widget/back_button.dart';


class FriendsAppbar extends AppBar {
  FriendsAppbar({Key? key})
      : super(
          key: key,
          actions: [],
          leading: const FriendsBackButton(),
        );
}
