import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:friends/core/common_widget/app_bar.dart';
import 'package:friends/core/common_widget/bottom_navigation_bar.dart';
import 'package:friends/core/common_widget/drawer.dart';
import 'package:friends/core/common_widget/snackbar_widget.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/icon_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/routes/routes.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/features/home_page/presentation/manager/homepage_bloc.dart';
import 'package:responsive_s/responsive_s.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController(
      initialPage: 2,
      keepPage: true
  );
  UserEntity? user ;


  @override
  initState() {
    super.initState();
    BlocProvider.of<HomepageBloc>(context).add(LoadUserEvent(context));
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return BlocConsumer<HomepageBloc, HomepageState>(
      listener: (context, state) {
        if (state is UserNotLoadedState) {
          ScaffoldMessenger.of(context).showSnackBar(MessageSnackBar(
              context, responsive: responsive,
              borderColor: ColorManager.bellColor,
              textHeaderColor: ColorManager.bellColor,
              textHeader: StringManager.login,
              animationString: AssetsManager.bellAnimation,
              errorMessage: StringManager.youAreNotLoggedIn));
        }else{
          if(state is StudentState ){
            user = state.user;
          }else if(state is CenterState){
            user = state.user;
          }else{
            debugPrint("NO USER FOUND IN ELSE STATE");
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          drawerEnableOpenDragGesture: true,
          drawer: FriendsDrawer(
            user:user==null?null: UserEntity(
              email: user?.email??ConstantManager.stackHolderEmail,
              imageUrl:user?.imageUrl ,
              name: user?.name??ConstantManager.stackHolderName,
              user: user?.user??ConstantManager.studentType,
              address: user?.address,
              subscribeId: user?.subscribeId,
            ),
          ),
          appBar: FriendsAppbar(
            backButton: false,
            containLogo: true,
          ),
          bottomNavigationBar: BlocProvider<NavigationBarBloc>(
            create: (context) => NavigationBarBloc(),
            child: FriendsNavigationBar(
              initialIndex: 2,
              onTap: (index) {
                if (index < _buildItems().length) {
                  _controller.animateToPage(
                      index, duration: const Duration(milliseconds: 400),
                      curve: Curves.linear);
                }
              },
              height: responsive.responsiveHeight(forUnInitialDevices: 11),
              iconSize: 20,
              items: const [
                MyFlutterApp.scanBarCode,
                MyFlutterApp.barCode,
                MyFlutterApp.home,
                MyFlutterApp.cash,
                MyFlutterApp.bell
              ],
            ),
          ),
          body: PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: _buildItems(),
          ),
        );
      },
    );
  }

  //
  List<Widget> _buildItems() {
    List<Widget> icons = [
      RoutesManager.routesWhere(Routes.qrScanner),
      RoutesManager.routesWhere(Routes.qrGenerator),
      RoutesManager.routesWhere(Routes.offer),
      RoutesManager.routesWhere(Routes.subscriptionsPackages),
      Icon(MyFlutterApp.bell),
    ];
    return icons;
  }
}



