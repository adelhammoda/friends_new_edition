import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:friends/core/common_widget/app_bar.dart';
import 'package:friends/core/common_widget/bottom_navigation_bar.dart';
import 'package:friends/core/common_widget/drawer.dart';
import 'package:friends/core/manager/icon_manager.dart';
import 'package:friends/core/routes/routes.dart';
import 'package:friends/features/login/domain/entities/user_entity.dart';
import 'package:responsive_s/responsive_s.dart';

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);
  final PageController _controller = PageController(
    initialPage: 2,
    keepPage: true
  );

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawerEnableOpenDragGesture: true,
      drawer: FriendsDrawer(
        user: UserEntity(
          email: "test@gmail.com",
          imageUrl: null,
          name: "Test",
          user: "Student",
          address: {},
          subscribeId: '',
        ),
      ),
      appBar: FriendsAppbar(
        backButton: false,
        containLogo: true,
      ),
      bottomNavigationBar: BlocProvider<NavigationBarBloc>(
        create: (context) => NavigationBarBloc(),
        child:  FriendsNavigationBar(
          initialIndex: 2,
          onTap: (index){
            if(index<_buildItems().length) {
              _controller.animateToPage(index, duration: const Duration(milliseconds: 400),curve: Curves.linear);
            }
          },
          height: responsive.responsiveHeight(forUnInitialDevices: 11),
          iconSize: 20,
          items:const [
            MyFlutterApp.scanBarCode,
            MyFlutterApp.barCode,
            MyFlutterApp.home,
            MyFlutterApp.cash,
            MyFlutterApp.bell
          ],
        ),
      ),
      body: PageView(
        controller:_controller ,
        physics: const NeverScrollableScrollPhysics(),
        children:_buildItems(),
      ),
    );
  }

  //
  List<Widget> _buildItems() {
    List<Widget> icons =  [
      Icon(MyFlutterApp.home),
      Icon(MyFlutterApp.cash),
     RoutesManager.routesWhere(Routes.offer),
      Icon(MyFlutterApp.bell),
      Icon(MyFlutterApp.bell),
    ];
    return icons;
  }
}
