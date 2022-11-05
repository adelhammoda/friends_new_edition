part of 'offerpage_offer_bloc.dart';

@immutable
abstract class OfferPageEvent extends Equatable {}

class OfferPageLoadOffersEvent extends OfferPageEvent {
  OfferPageLoadOffersEvent();

  @override
  List<Object?> get props => [];
}

class OfferPageRefreshEvent extends OfferPageEvent {
  @override
  List<Object?> get props => [];
}

class OfferPageSearchEvent extends OfferPageEvent{
  final String searchKey;

  OfferPageSearchEvent(this.searchKey);
  @override
  List<Object?> get props => [searchKey];
}


class OfferPageLoadFavoriteEvent extends OfferPageEvent{

  OfferPageLoadFavoriteEvent( );
  @override
  List<Object?> get props =>[];
}
class OfferPageAddToFavoriteEvent extends OfferPageEvent{
  final  String offerId;

  OfferPageAddToFavoriteEvent(this.offerId);


  @override
  List<Object?> get props => [];

}
class OfferPageNavigateToDetailsEvent extends OfferPageEvent{
  final BuildContext context;
  final OfferEntity offer;
  final OfferPageBloc blocValue;

  OfferPageNavigateToDetailsEvent(this.offer, this.context, this.blocValue);

  @override
  List<Object?> get props => [offer];
}

class OfferPageLoadUserDetailsEvent extends OfferPageEvent{
  final String userId;

  OfferPageLoadUserDetailsEvent(this.userId);
  @override
  List<Object?> get props => [userId];
}

class OfferPageRemoverFromFavoriteEvent extends OfferPageEvent{
  final String offerId;

  OfferPageRemoverFromFavoriteEvent(this.offerId);
  @override
  List<Object?> get props => [offerId];

}