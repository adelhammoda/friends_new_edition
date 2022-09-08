import 'package:flutter/material.dart';
import 'package:friends/core/common_widget/app_bar.dart';
import 'package:friends/core/common_widget/background_widget.dart';
import 'package:friends/core/manager/color_manager.dart';

import '../../../../core/common_widget/footer.dart';

class LoginPage extends StatelessWidget {

  const LoginPage(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: FriendsAppbar(),
      bottomNavigationBar:const Footer(
        ///example of url that worked natively "mailto:adel@gmail.com"
        emailUrlNatively:'emailNativelyUrl' ,
        ///example of url that worked natively 'fb://profile/100004920094579'
        facebookUrlNatively:'facebookNativelyUrl' ,
        ///example of url that worked natively 'instagram://user?username=aadel_hammoda'
        instagramUrlNatively:"instagramNativelyUrl" ,
        ///example of url that work in web-view mood "https://www.gmail.com"
        emailUrl: "emailUrl",
        ///example of url that work in web-view mood 'https://www.facebook.com/aadel.hammoda'
        facebookUrl: "facebookUrl",
        ///example of url that work in web-view mood 'https://www.instagram.com/moaazallaham/'
        instagramUrl: "instagramUrl",
      ),
      body:const FriendsBackgroundWidget() ,
    );
  }
}
