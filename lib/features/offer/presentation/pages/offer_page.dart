import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_widget/loader.dart';
import 'package:friends/core/common_widget/snackbar_widget.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/icon_manager.dart';
import 'package:friends/core/manager/status_code_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/offer/presentation/manager/offerpage_offer_bloc.dart';
import 'package:friends/features/offer/presentation/widgets/favorite_tab.dart';
import 'package:friends/features/offer/presentation/widgets/offer_tab.dart';
import 'package:friends/features/offer/presentation/widgets/offer_tab_bar.dart';
import 'package:friends/features/offer/presentation/widgets/search_bar.dart';
import 'package:responsive_s/responsive_s.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage>
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
    return Scaffold(

      body: Column(
        children: [
          SearchBar(
            controller: controller,
          ),
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
              child: BlocConsumer<OfferPageBloc, OfferPageState>(
                buildWhen: (oldState,currentState){
                  return oldState!=currentState;
                },
                listenWhen: (oldState,currentState)=>currentState is OfferPageInitialState||currentState is OfferPageErrorState,
                listener: (context, state) {
                  stateListener(state, responsive);
                },
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        stateSwitcherForOffersTab(state, responsive),
                        FavoriteTab(
                            favorite:
                            BlocProvider
                                .of<OfferPageBloc>(context)
                                .favorite,
                            listOfFavorite:
                            BlocProvider
                                .of<OfferPageBloc>(context)
                                .offers
                                ),
                      ],
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }

  Widget stateSwitcherForOffersTab(OfferPageState state,
      Responsive responsive,) {
    switch (state.runtimeType) {
      case OfferPageInitialState:
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          BlocProvider.of<OfferPageBloc>(context).add(OfferPageLoadOffersEvent());
        });
        return Center(
            child: SizedBox(
              width: responsive.responsiveWidth(forUnInitialDevices: 20),
              height: responsive.responsiveWidth(forUnInitialDevices: 20),
              child: const Loader(),
            ));
      case OfferPageLoadingState:
        return Center(
            child: SizedBox(
              width: responsive.responsiveWidth(forUnInitialDevices: 20),
              height: responsive.responsiveWidth(forUnInitialDevices: 20),
              child: const Loader(),
            ));
      case OfferPageLoadedState:
        return OfferTab(
            offers: (state as OfferPageLoadedState).offers,
            favoritesOffersId: (state).favorite);

      case OfferPageErrorState:
        return  SizedBox(
            width: double.infinity,
            height: double.infinity,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             const Center(child: Text(StringManager.noDataErrorMessage)),
            IconButton(onPressed: (){}, icon: const Icon(MyFlutterApp.cw,color: ColorManager.red,))
          ],
        ));
      default:
        return const SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Center(child: Text(StringManager.noDataErrorMessage)));
    }
  }

  void stateListener(OfferPageState state, Responsive responsive) {
    switch (state.runtimeType) {
      case OfferPageErrorState:
        if ((state as OfferPageErrorState).failure.statusCode ==
            StatusCode.noData) {
          break;
        }
        ScaffoldMessenger.of(context).showSnackBar(MessageSnackBar(context,
            responsive: responsive,
            errorMessage: state.failure.message));
        break;
    }
  }
}
