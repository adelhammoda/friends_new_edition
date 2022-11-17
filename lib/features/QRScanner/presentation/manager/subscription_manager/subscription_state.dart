part of 'subscription_bloc.dart';

@immutable
abstract class SubscriptionQrScannerState extends Equatable {
  const SubscriptionQrScannerState();
}

class SubscriptionInitial extends SubscriptionQrScannerState {
  @override
  List<Object?> get props => [];
}

class SubscriptionQrScannerLoadingState extends SubscriptionQrScannerState {
  @override
  List<Object?> get props => [];
}

class SubscriptionQrScannerErrorState extends SubscriptionQrScannerState {
  final Failure failure;

  const SubscriptionQrScannerErrorState({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class SubscriptionQrScannerLoadedState extends SubscriptionQrScannerState {
  final List<SubscriptionEntity> subscriptionEntity;
  final List<String?> centerInfo;

  const SubscriptionQrScannerLoadedState(
      {required this.subscriptionEntity, required this.centerInfo});

  @override
  List<Object?> get props => [subscriptionEntity,centerInfo];
}
