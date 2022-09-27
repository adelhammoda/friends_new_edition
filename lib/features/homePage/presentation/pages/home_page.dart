import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_widget/app_bar.dart';
import 'package:friends/core/common_widget/drawer.dart';
import 'package:friends/core/common_widget/loader.dart';
import 'package:friends/core/common_widget/snackbar_widget.dart';
import 'package:friends/core/manager/status_code_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/homePage/presentation/manager/homepage_bloc.dart';
import 'package:friends/features/homePage/presentation/widgets/offer_tab.dart';
import 'package:friends/features/homePage/presentation/widgets/offer_tab_bar.dart';
import 'package:friends/features/homePage/presentation/widgets/search_bar.dart';
import 'package:friends/features/login/domain/entities/user_entity.dart';
import 'package:responsive_s/responsive_s.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {


  final TextEditingController controller = TextEditingController();
  ValueNotifier<int> index = ValueNotifier(0);
  late final TabController tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: index.value,
      animationDuration: const Duration(milliseconds: 400));

  @override
  initState() {
    super.initState();
    tabController.addListener(() {
      index.value = tabController.index;
    });
  }

  @override
  dispose() {
    tabController.dispose();
    index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return  Scaffold(
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
        body: Column(
          children: [
            SearchBar(controller: controller),
            ValueListenableBuilder<int>(
                valueListenable: index,
                builder: (c, index, _) =>
                    OfferTabBar(
                      onTap: (index) {
                        tabController.animateTo(index);
                      },
                      index: index,
                    )),
            Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      BlocBuilder<HomepageBloc, HomepageState>(
                        builder: (c, state) {
                         return stateSwitcher(state,responsive);
                        },
                      ),
                      Text("hello2"),
                    ],
                  ),
                ))
          ],
        ),
    );
  }

  Widget stateSwitcher(HomepageState state,Responsive responsive) {
    print(state.runtimeType);

    switch (state.runtimeType) {
      case HomepageErrorState:
        if ((state as HomepageErrorState).failure.statusCode ==
            StatusCode.noData) {
          return Center(child: Text(state.failure.message),);
        } else {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(MessageSnackBar(
                context, responsive: responsive,
                success: false,
                errorMessage: state.failure.message));
          });
          return const Text(StringManager.noDataErrorMessage);
        }
      case HomepageOffersLoadedState:
        if((state as HomepageOffersLoadedState).offers.isEmpty){
          return Center(child: Text("no data"),);
        }
        return OfferTab(offers: (state as HomepageOffersLoadedState).offers);
      case HomepageLoadingOffersState:
        return Center(child: SizedBox(
          width: responsive.responsiveWidth(forUnInitialDevices: 20),
          height: responsive.responsiveWidth(forUnInitialDevices: 20),
          child: const Loader(),
        ),);
      case HomepageInitial:
        {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            BlocProvider.of<HomepageBloc>(context).add(
                HomepageLoadOffersEvent());
          });
          return Center(child: SizedBox(
            width: responsive.responsiveWidth(forUnInitialDevices: 20),
            height: responsive.responsiveWidth(forUnInitialDevices: 20),
            child: const Loader(),
          ),);
        }
      default:
        return const Center(child: Text(StringManager.noDataErrorMessage));
    }
  }
}
