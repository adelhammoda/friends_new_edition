import 'package:flutter/material.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/size_manager.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/offer/domain/entities/offer.dart';
import 'package:friends/features/offer/presentation/manager/offerpage_offer_bloc.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:responsive_s/responsive_s.dart';

Widget buildUserSection(
        OfferPageBloc homeBloc, OfferEntity offer, Responsive responsive) =>
    FutureBuilder<UserEntity?>(
        future: homeBloc
            .loadUserDetails(OfferPageLoadUserDetailsEvent(offer.offerOwnerId)),
        builder: (BuildContext context, AsyncSnapshot<UserEntity?> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.white,
                        border:
                            Border.all(color: ColorManager.darkGrey, width: 2)),
                    width: responsive.responsiveWidth(forUnInitialDevices: 10),
                    height: responsive.responsiveWidth(forUnInitialDevices: 10),
                    child: FadeInImage(
                      fit: BoxFit.fill,
                      imageErrorBuilder: (c, _, __) =>
                          Image.asset(AssetsManager.userPlaceHolderIcon),
                      image: NetworkImage(snapshot.data!.imageUrl ?? ""),
                      placeholder:
                          const AssetImage(AssetsManager.userPlaceHolderIcon),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    snapshot.data!.name,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: ColorManager.black.withOpacity(0.4)),
                  ),
                )
              ],
            );
          } else {
            return Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.white,
                        border:
                            Border.all(color: ColorManager.darkGrey, width: 2)),
                    width: responsive.responsiveWidth(forUnInitialDevices: 10),
                    height: responsive.responsiveWidth(forUnInitialDevices: 10),
                    child: const FadeInImage(
                      fit: BoxFit.fill,
                      image: AssetImage(AssetsManager.userPlaceHolderIcon),
                      placeholder:
                          AssetImage(AssetsManager.userPlaceHolderIcon),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    "......",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: ColorManager.black.withOpacity(0.4)),
                  ),
                )
              ],
            );
          }
        });

List<Widget> buildInfo(
    List<Map>? info, BuildContext context, Responsive responsive) {
  if (info == null) {
    return [];
  }
  return info
      .map(
        (map) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              map.keys.first.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 17,fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: responsive.responsiveWidth(forUnInitialDevices: 10)),
              child: Text(
                map.values.first.toString(),
              ),
            ),
          ],
        ),
      )
      .toList();
}

Widget buildDivider()=>Divider(
  thickness: 1.5,
  color: ColorManager.darkGrey.withOpacity(0.4),
);



Widget buildDescription(BuildContext context,String? description){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(padding: const EdgeInsets.only(bottom: 8,
         ), child:
      Text(StringManager.description(context),
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: SizeManager.subTitle,
          shadows: [],
        ),)),
      Text(description??'',style: Theme.of(context).textTheme.labelMedium,)
    ],
  );
}
