import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/manager/color_manager.dart';
import 'package:friends/core/manager/icon_manager.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:friends/features/homePage/presentation/manager/homepage_offer_bloc.dart';
import 'package:responsive_s/responsive_s.dart';

class OfferWidget extends StatefulWidget {
  final OfferEntity offer;
  bool isFavorite;
  final VoidCallback? afterTapped;
  OfferWidget(
      {Key? key,
      required this.isFavorite,
      required this.offer, this.afterTapped})
      : super(key: key);

  @override
  State<OfferWidget> createState() => _OfferWidgetState();
}

class _OfferWidgetState extends State<OfferWidget> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return InkWell(
      onTap: () {
        BlocProvider.of<HomepageBloc>(context).navigateToDetailsUseCases(
          context: context,
          offer: widget.offer
        );
      },
      child: Padding(
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
                    widget.offer.imagesUrl.first,
                  ),
                  fit: BoxFit.fill)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      widget.offer.name.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 25),
                    ),
                  ),
                  Text(
                    "${widget.offer.value}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorManager.importantText, fontSize: 16),
                  )
                ],
              ),
              SizedBox(
                height: responsive.responsiveHeight(forUnInitialDevices: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          !widget.isFavorite
                              ? BlocProvider.of<HomepageBloc>(context).add(
                                  HomepageAddToFavoriteEvent(widget.offer.id))
                              : BlocProvider.of<HomepageBloc>(context).add(
                                  HomepageRemoverFromFavoriteEvent(
                                      widget.offer.id,));
                          setState(() {
                            widget.isFavorite = !widget.isFavorite;
                          });
                          widget.afterTapped?.call();
                        },
                        icon: Icon(
                          widget.isFavorite
                              ? MyFlutterApp.favoriteEnabled
                              : MyFlutterApp.favoriteDisabled,
                          color: ColorManager.favoriteColor,
                        )),
                    Text(
                      "${widget.offer.discount}%",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorManager.importantText, fontSize: 15),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
