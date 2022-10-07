import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_widget/loader.dart';
import 'package:friends/features/offer/domain/entities/offer.dart';
import 'package:friends/features/offer/presentation/manager/offerpage_offer_bloc.dart';
import 'package:friends/features/offer/presentation/widgets/offer_widget.dart';

class OfferTab extends StatelessWidget {
  final List<OfferEntity> offers;
  final Set<String> favoritesOffersId;
  const OfferTab({Key? key, required this.offers, required this.favoritesOffersId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      child: CustomRefreshIndicator(

        onRefresh: () async{
         await BlocProvider.of<OfferpageBloc>(context).refreshOffers(HomepageRefreshEvent());
        },
        builder: (BuildContext context, Widget child, IndicatorController controller) {

          return AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, _) {
              return Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  if (!controller.isIdle)
                    Positioned(
                      top: 35.0 * controller.value,
                      child:const Loader(),
                    ),
                  Transform.translate(
                    offset: Offset(0, 100.0 * controller.value),
                    child: child,
                  ),
                ],
              );
            },
          );
        },
        child: ListView.builder(
            itemCount: offers.length,
            itemBuilder: (c, index) {
              bool isFavorite =  favoritesOffersId.contains(offers[index].id);
              return  OfferWidget(
                offer: offers[index],
                isFavorite:isFavorite,
              );}),
      ),
    );
  }
}
