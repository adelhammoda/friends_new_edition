part of 'offerpage_offer_bloc.dart';

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

  HomepageSearchEvent(this.searchKey);
  @override
  List<Object?> get props => [searchKey];
}


class HomepageLoadFavoriteEvent extends HomepageEvent{

  HomepageLoadFavoriteEvent( );
  @override
  List<Object?> get props =>[];
}
class HomepageAddToFavoriteEvent extends HomepageEvent{
  final  String offerId;

  HomepageAddToFavoriteEvent(this.offerId);


  @override
  List<Object?> get props => [];

}
class HomepageNavigateToDetailsEvent extends HomepageEvent{
  final BuildContext context;
  final OfferEntity offer;
  final OfferpageBloc blocValue;

  HomepageNavigateToDetailsEvent(this.offer, this.context, this.blocValue);

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

  HomepageRemoverFromFavoriteEvent(this.offerId);
  @override
  List<Object?> get props => [offerId];

}