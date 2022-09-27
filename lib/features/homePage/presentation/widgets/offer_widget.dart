import 'package:flutter/material.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:responsive_s/responsive_s.dart';

class OfferWidget extends StatelessWidget {
  final OfferEntity offer;

  const OfferWidget({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: responsive.responsiveWidth(forUnInitialDevices: 5),
          vertical: 13),
      child: Container(
        padding: const EdgeInsets.only(left: 13, bottom: 10),
        height: responsive.responsiveHeight(forUnInitialDevices: 25),
        width: responsive.responsiveWidth(forUnInitialDevices: 80),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: ColorManager.darkGrey,
            image: DecorationImage(
                image: NetworkImage(
                  offer.imagesUrl.first,
                ),
                fit: BoxFit.fill)),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    offer.name.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 25),
                  ),
                ),
                Text(
                  "${offer.value}",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: ColorManager.importantText,fontSize: 16),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
