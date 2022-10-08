import 'package:flutter/material.dart';
import 'package:friends/core/common_widget/back_button.dart';
import 'package:friends/core/manager/string_manager.dart';


class FriendsAppbar extends AppBar {
  FriendsAppbar({Key? key,bool containLogo=false,bool backButton = true,List<Widget>? actions,bool isGrey =true })
      : super(
          key: key,
          actions: _buildAction(containLogo,actions??[]),
          leading:backButton?  FriendsBackButton(isGrey:isGrey):null,
        );



 static List<Widget>? _buildAction(bool withLogo , List<Widget> actions){
   if(withLogo){
     return [Image.asset(AssetsManager.smallLogo),...actions];
   }else {
     return actions;
   }
 }
}
