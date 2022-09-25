import 'package:flutter/material.dart';
import 'package:friends/core/common_widget/back_button.dart';
import 'package:friends/core/manager/string_manager.dart';


class FriendsAppbar extends AppBar {
  FriendsAppbar({Key? key,bool containLogo=false,bool backButton = true,List<Widget>? actions })
      : super(
          key: key,
          actions: _buildAction(containLogo,actions??[]),
          leading:backButton? const FriendsBackButton():null,
        );



 static List<Widget>? _buildAction(bool withLogo , List<Widget> actions){
   if(withLogo){
     return [Image.asset(AssetsManager.mediumLogo),...actions];
   }else {
     return actions;
   }
 }
}
