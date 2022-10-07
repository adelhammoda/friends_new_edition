import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/offer/domain/entities/offer.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_s/responsive_s.dart';

import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/size_manager.dart';

class ImageInDetailsScreen extends StatelessWidget {
  final OfferEntity offer;

  const ImageInDetailsScreen({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: SizedBox(
        height: responsive.responsiveHeight(forUnInitialDevices: 35),
        child: Stack(
          children: <Widget>[
            CarouselSlider(
              items: offer.imagesUrl
                  .map((url) => FadeInImage(
                      placeholder: const AssetImage(
                        AssetsManager.bigLogo,
                      ),
                      fit: BoxFit.fill,
                      placeholderFit: BoxFit.fill,
                      width: double.infinity,
                      image: NetworkImage(url)))
                  .toList(),
              options: CarouselOptions(
                height: double.infinity,
                viewportFraction: 1,
                autoPlay: true,
              ),
            ),
            Transform.translate(
                transformHitTests: true,
                offset: Offset(
                    -responsive.responsiveWidth(forUnInitialDevices: 27),
                    responsive.responsiveHeight(forUnInitialDevices: 3)),
                child: Transform.rotate(
                  alignment: Alignment.center,
                  angle: -49 * pi / 180,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorManager.red.withOpacity(0.7),
                        border: Border.all(color: ColorManager.darkGrey)),
                    width: responsive.responsiveWidth(forUnInitialDevices: 70),
                    height: 50,
                    child: Text(
                      "${offer.discount}%",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: ColorManager.white,
                          fontSize: SizeManager.titleMedium),
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width:
                            responsive.responsiveWidth(forUnInitialDevices: 30),
                        height:
                            responsive.responsiveWidth(forUnInitialDevices: 20),
                        decoration: BoxDecoration(
                            color: ColorManager.black.withOpacity(0.5),
                            border: const Border(
                                bottom:
                                    BorderSide(color: ColorManager.darkGrey),
                                // left: BorderSide(color: ColorManager.darkGrey),
                                top: BorderSide(color: ColorManager.darkGrey),
                                right:
                                    BorderSide(color: ColorManager.darkGrey))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                "${offer.value}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: ColorManager.white,
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 4),
                              ),
                            ),
                            Text(
                              "${offer.value * (100 - offer.discount) / 100}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: ColorManager.white,
                                  ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width:
                            responsive.responsiveWidth(forUnInitialDevices: 30),
                        height:
                            responsive.responsiveWidth(forUnInitialDevices: 20),
                        child: Lottie.asset(AssetsManager.shiningAnimation),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
