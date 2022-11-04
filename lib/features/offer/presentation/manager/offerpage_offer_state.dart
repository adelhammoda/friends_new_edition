part of 'offerpage_offer_bloc.dart';

@immutable
abstract class OfferPageState extends Equatable{}



class OfferPageInitialState extends OfferPageState{
  @override
  List<Object?> get props => [];
}


class OfferPageLoadingState extends OfferPageState{
  @override
  List<Object?> get props => [];
}


class OfferPageLoadedState extends OfferPageState{
  final List<OfferEntity> offers;
  final Set<String> favorite;

  OfferPageLoadedState(this.offers, this.favorite);
  @override
  List<Object?> get props => [offers,favorite];
}


class OfferPageErrorState extends OfferPageState{
  final Failure failure;

  OfferPageErrorState(this.failure);
  @override
  List<Object?> get props => [failure];
}

