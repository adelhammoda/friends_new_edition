import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_widget/app_bar.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/navigation/navigator.dart';
import 'package:friends/features/offer/domain/entities/offer.dart';
import 'package:friends/features/offer/presentation/manager/offerpage_offer_bloc.dart';
import 'package:friends/features/offer/presentation/widgets/functions_for_details_screen.dart';
import 'package:friends/features/offer/presentation/widgets/image_in_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:responsive_s/responsive_s.dart';

class OfferDetailsPage extends StatelessWidget {
  const OfferDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    OfferPageBloc? homeBloc;
    OfferEntity? offer;
    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments is Map &&
        (settings.arguments as Map)['offers'] != null &&
        (settings.arguments as Map)['bloc'] != null) {
      offer = (settings.arguments as Map)['offers'];
      homeBloc = (settings.arguments as Map)['bloc'];
    } else {
      Go.back(context, null);
    }

    return BlocProvider<OfferPageBloc>.value(
      value: homeBloc!,
      child: Scaffold(
        appBar: FriendsAppbar(
          containLogo: true,
          backButton: true,
          isGrey: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ImageInDetailsScreen(offer: offer!),
              _buildBody(responsive,context,offer,homeBloc),

            ],
          ),
        ),
      ),
    );
  }
  Widget _buildBody(Responsive responsive,BuildContext context,OfferEntity offer,
      OfferPageBloc homeBloc)=> Padding(
    padding: EdgeInsets.symmetric(
      horizontal:
      responsive.responsiveWidth(forUnInitialDevices: 10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //offer name
        Padding(padding:const EdgeInsets.only(bottom: 8),
        child: Text(
          offer.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child:buildUserSection(homeBloc,offer,responsive),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: responsive.responsiveWidth(
                  forUnInitialDevices: 10)),
          child: Text(
            "${offer.totalCapacity ?? ""}  ",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        buildDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(DateFormat.yMEd().format(offer.startDate),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 15
              ),),
            Icon(
              Icons.arrow_forward,
              size: 50,
              color: ColorManager.black.withOpacity(0.5),
            ),
            Text(DateFormat.yMEd().format(offer.endDate),style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 15
            ),),
          ],
        ),
        buildDivider(),

        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:buildInfo(offer.info,context,responsive),
          ),
        ),
        buildDivider(),
        buildDescription(context,offer.description),
      ],
    ),
  );
}
