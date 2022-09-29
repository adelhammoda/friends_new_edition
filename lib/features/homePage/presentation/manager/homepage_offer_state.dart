part of 'homepage_offer_bloc.dart';

@immutable
abstract class HomepageState extends Equatable{}



class HomepageInitialState extends HomepageState{
  @override
  List<Object?> get props => [];
}


class HomepageLoadingState extends HomepageState{
  @override
  List<Object?> get props => [];
}


class HomepageLoadedState extends HomepageState{
  final List<OfferEntity> offers;
  final Set<String> favorite;

  HomepageLoadedState(this.offers, this.favorite);
  @override
  List<Object?> get props => [offers,favorite];
}


class HomepageErrorState extends HomepageState{
  final Failure failure;

  HomepageErrorState(this.failure);
  @override
  List<Object?> get props => [failure];
}

