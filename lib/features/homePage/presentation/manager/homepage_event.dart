part of 'homepage_bloc.dart';

@immutable
abstract class HomepageEvent extends Equatable {}

class HomepageLoadOffersEvent extends HomepageEvent {
  HomepageLoadOffersEvent();

  @override
  List<Object?> get props => [];
}

class HomepageRefreshEvent extends HomepageEvent {
  @override
  List<Object?> get props => [];
}

class HomepageSearchEvent extends HomepageEvent{
  final String searchKey;
  final List<OfferEntity> oldOffers;

  HomepageSearchEvent(this.searchKey,this.oldOffers);
  @override
  List<Object?> get props => [searchKey];
}


class HomepageLoadFavoriteEvent extends HomepageEvent{
  @override
  List<Object?> get props =>[];
}
class HomepageAddToFavoriteEvent extends HomepageEvent{
  final  OfferEntity offer;

  HomepageAddToFavoriteEvent(this.offer);


  @override
  List<Object?> get props => [offer];

}
class HomepageNavigateToDetailsEvent extends HomepageEvent{
  final BuildContext context;
  final OfferEntity offer;

  HomepageNavigateToDetailsEvent(this.offer, this.context);

  @override
  List<Object?> get props => [offer];
}

class HomepageLoadUserDetailsEvent extends HomepageEvent{
  final String userId;

  HomepageLoadUserDetailsEvent(this.userId);
  @override
  List<Object?> get props => [userId];
}

class HomepageRemoverFromFavoriteEvent extends HomepageEvent{
  final String offerId;
  final List<OfferEntity> offers;
  HomepageRemoverFromFavoriteEvent(this.offerId, this.offers);
  @override
  List<Object?> get props => [offerId];

}