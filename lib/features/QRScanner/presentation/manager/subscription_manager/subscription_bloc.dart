import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:friends/core/common_entity/user_entity.dart';
import 'package:friends/core/extension/string_extension.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/QRScanner/domain/entities/subscribe_entity.dart';
import 'package:friends/features/QRScanner/domain/use_cases/get_all_subscriptions_info_use_case.dart';
import 'package:friends/features/QRScanner/domain/use_cases/get_subscription_center_info.dart';
import 'package:friends/features/QRScanner/domain/use_cases/get_user_subscribes_use_case.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';
part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionQrScannerBloc
    extends Bloc<SubscriptionQrScannerEvent, SubscriptionQrScannerState> {
  final GetAllSubscriptionsInfoUseCase getAllSubscriptionsInfoUseCase;
  final GetSubscriptionCenterInfo getSubscriptionCenterInfo;
  final GetUserSubscribesUseCase getUserSubscribesUseCase;

  SubscriptionQrScannerBloc({
    required this.getUserSubscribesUseCase,
    required this.getAllSubscriptionsInfoUseCase,
    required this.getSubscriptionCenterInfo,
  }) : super(SubscriptionInitial()) {
    on<SubscriptionQrScannerEvent>((event, emit) async {
      if (event is LoadUserSubscriptionsEvent) {
        if(event.userId.isNullOrEmpty()){
          emit(const SubscriptionQrScannerErrorState(failure: NoDataFailure()));
        }else {
          emit(SubscriptionQrScannerLoadingState());
          final Either<Failure, List<SubscribeEntity>> res =
          await getUserSubscribesUseCase(userId: event.userId!);
          await res.fold<Future<void>>(
                  (failure) async{
                  emit(SubscriptionQrScannerErrorState(failure: failure));
                  return ;},
                  (data) async {
                List<String?> centersInfo = [];
                centersInfo = data.map((e) => e.centerId).toList();
                final subscriptionPackages = await getAllSubscriptionsInfoUseCase(
                    subscriptionsPackagesId:
                    data.map((e) => e.subscriptionTypeId).toList());
                subscriptionPackages.fold(
                        (failure) =>
                        emit(SubscriptionQrScannerErrorState(failure: failure)),
                        (userPackages) {
                      emit(SubscriptionQrScannerLoadedState(
                          subscriptionEntity: userPackages,
                          centerInfo: centersInfo));
                    });
              });
        }
      } else {
        emit(SubscriptionInitial());
      }
    });
  }

  Future<UserEntity?> getCenterDetails(String centerId) async {
    final res = await getSubscriptionCenterInfo(centerId: centerId);
    return res.fold((l) => null, (userEntity) => userEntity);
  }

}
