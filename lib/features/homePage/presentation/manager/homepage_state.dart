part of 'homepage_bloc.dart';

@immutable
abstract class HomepageState extends Equatable{}

class HomepageInitial extends HomepageState {
  @override
  List<Object?> get props => [];


}


class HomepageOffersLoadedState extends HomepageState{
  final List<OfferEntity> offers;

  HomepageOffersLoadedState(this.offers);

  @override
  List<Object?> get props =>[offers];

}

class HomepageLoadingOffersState extends HomepageState{
  @override
  List<Object?> get props => [];
}

class HomepageErrorState extends HomepageState{
  final Failure failure;

  HomepageErrorState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class HomepageNoDataState extends HomepageState{
  final NoDataFailure failure;

  HomepageNoDataState(this.failure);

  @override
  List<Object?> get props => [failure];
}

class HomePageRefreshLoadedState extends HomepageState{
  final List<OfferEntity> offers;
  HomePageRefreshLoadedState(this.offers);

  @override
  List<Object?> get props =>[offers];
}
class HomePageRefreshLoadingState extends HomepageState{
  @override
  List<Object?> get props =>[];
}
class HomepageRefreshErrorState extends HomepageState{
  final Failure failure;
  HomepageRefreshErrorState(this.failure);
  @override
  List<Object?> get props =>[failure];
}

class HomepageLoadingUserDetailsState extends HomepageState{
  @override
  List<Object?> get props =>[];
}

class HomepageErrorUserDetailsState extends HomepageState{
  final Failure failure;
  HomepageErrorUserDetailsState(this.failure);
  @override
  List<Object?> get props =>[failure];
}

class HomepageLoadedUserDetailsState extends HomepageState{
  final UserEntity user;

  HomepageLoadedUserDetailsState(this.user);

  @override
  List<Object?> get props => [user];

}

class HomepageAddToFavoriteDoneAnimationState extends HomepageState{
  @override
  List<Object?> get props => [];
}