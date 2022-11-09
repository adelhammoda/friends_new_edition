import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';
import 'package:friends/features/subscription/domain/use_cases/fetch_all_packages.dart';
import 'package:friends/features/subscription/domain/use_cases/get_packages_from_cash.dart';


part 'subscription_event.dart';

part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final FetchAllPackagesUseCases fetchAllPackagesUseCases;
  final GetPackagesFromCashUseCases getPackagesFromCashUseCases;

  SubscriptionBloc({
    required this.fetchAllPackagesUseCases,
    required this.getPackagesFromCashUseCases,
  }) : super(SubscriptionInitial()) {

    on<SubscriptionEvent>((event, emit) async {
      if (event is LoadSubscriptionsEvent) {
        emit(SubscriptionLoading());
        Either<Failure, List<SubscriptionEntity>> res =
            await fetchAllPackagesUseCases();
         await res.fold<Future<void>>((failure)  async{
          emit(SubscriptionError(failure: failure));
          if (failure is NetworkFailure) {
            emit(SubscriptionLoading());
            Either<Failure, List<SubscriptionEntity>> cashedList =
                await getPackagesFromCashUseCases();
            cashedList.fold(
                (l) {
                    emit(SubscriptionNoState());
                },
                (subscriptionList) => emit(
                    SubscriptionLoaded(subscriptionList: subscriptionList)));
          }else{
              emit(SubscriptionNoState());
          }
        }, (subscriptionList) async=> emit(
            SubscriptionLoaded(subscriptionList: subscriptionList)));
      }
    });
    add(LoadSubscriptionsEvent());
  }
}
