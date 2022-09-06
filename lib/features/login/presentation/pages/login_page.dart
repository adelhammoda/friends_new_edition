import 'package:flutter/material.dart';
import 'package:friends/core/common_widget/app_bar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: FriendsAppbar(),
    );
  }
}
