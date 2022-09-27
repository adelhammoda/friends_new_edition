import 'package:flutter/material.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:friends/features/homePage/presentation/widgets/offer_widget.dart';

class OfferTab extends StatelessWidget {
  final List<OfferEntity> offers;

  const OfferTab({Key? key, required this.offers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: offers.length,
          itemBuilder: (c, index) => OfferWidget(
                offer: offers[index],
              )),
    );
  }
}
