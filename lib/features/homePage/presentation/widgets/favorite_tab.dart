import 'package:flutter/material.dart';
import 'package:friends/features/homePage/domain/entities/offer.dart';
import 'package:friends/features/homePage/presentation/widgets/offer_widget.dart';

class FavoriteTab extends StatefulWidget {
  final Set<String> favorite;
  final List<OfferEntity> listOfFavorite;

  const FavoriteTab(
      {Key? key, required this.favorite, required this.listOfFavorite})
      : super(key: key);

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  final GlobalKey<AnimatedListState> _listState = GlobalKey<AnimatedListState>();
  late final Tween<Offset> _animation;

  @override
  initState() {
    super.initState();
    _animation = Tween(begin:const Offset(1,0), end:const Offset(0,0),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<OfferEntity> favoriteOffers = widget.listOfFavorite
        .where((element) => widget.favorite.contains(element.id))
        .toList();
    return SizedBox(
      child: AnimatedList(
          key: _listState,
            initialItemCount: favoriteOffers.length,
            shrinkWrap: true,
            itemBuilder: (c, index, animation) {
              return OfferWidget(
                afterTapped: () {
                  //because its already removed so we will save it before delete;
                  final oldOffers = favoriteOffers[index];
                  favoriteOffers.removeAt(index);
                 _listState.currentState?.removeItem(
                      index,
                      (context, animation) => SlideTransition(
                          position: animation.drive(_animation),
                      child: OfferWidget(
                        isFavorite: false,
                        offer: oldOffers,
                      ),),
                 );
                },
                offer: favoriteOffers[index],
                isFavorite: true,
              );
            }),
    );
  }
}
